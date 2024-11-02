from sqlalchemy import create_engine
import pandas as pd

engine = engine = create_engine("postgresql+psycopg2://postgres:postgres@localhost:5432/heketon_malang3")
rest_id = 0

def fetch_kelurahan():
    global rest_id
    kelurahan = pd.read_sql(f'''
                                SELECT nama 
                                FROM Kelurahan 
                                WHERE kelurahan_id = {rest_id}
                            ''', engine).iloc[0, 0]
    return kelurahan

def fetch_preparation():
    global rest_id

    preparation = pd.read_sql(f'''
                            SELECT Preparation.date, Preparation_Item.porsi, Menu.nama as menu, Menu.harga, Bahan_Menu.kuantitas as kuantitas_bahan, Bahan.nama as nama_bahan
                            FROM Preparation
                            JOIN Preparation_Item ON Preparation.preparation_id = Preparation_Item.preparation_id
                            JOIN Menu ON Preparation_Item.menu_id = Menu.menu_id
                            JOIN Bahan_Menu ON Menu.menu_id = Bahan_Menu.menu_id
                            JOIN Bahan ON Bahan_Menu.bahan_id = Bahan.bahan_id
                            WHERE Preparation.restaurant_id = {rest_id}
                            ;
                        ''', engine)
    return preparation

def fetch_waste():
    
    global rest_id
    waste = pd.read_sql(f'''
                                SELECT date, food_in_gr as food_waste_in_gr
                                FROM Waste 
                                WHERE restaurant_id = {rest_id}
                            ''', engine)
    return waste

def fetch_bahan_from_menu(menu, r):
    global rest_id
    rest_id = r

    list_harga = []
    total_harga = []
    menus = list(menu.keys())
    rows = []
    bahan_rows = []
    for i in range(len(list(menu.values())[0])):
        temp = []
        for j in range(len(menus)):
            temp.append(menu[menus[j]][i])
        rows.append(temp)

    for row in rows:
        bahan = {}
        for a in range(len(menus)):
            preparation = pd.read_sql(f'''
                            SELECT Menu.nama as menu, Menu.harga, Bahan_Menu.kuantitas as kuantitas_bahan, Bahan.nama as nama_bahan
                            FROM Menu
                            JOIN Bahan_Menu ON Menu.menu_id = Bahan_Menu.menu_id
                            JOIN Bahan ON Bahan_Menu.bahan_id = Bahan.bahan_id
                            WHERE Menu.nama = '{menus[a]}'
                            ;
                        ''', engine)

            harga = preparation.iloc[0, 1]
            list_harga.append(int(harga))
            for idx, val in preparation.iterrows():
                quantity = val['kuantitas_bahan']
                nama_bahan = val['nama_bahan']
                jumlah_menu = row[a]

                if nama_bahan in bahan:
                    bahan[nama_bahan] += jumlah_menu * quantity
                else:
                    bahan[nama_bahan] = jumlah_menu * quantity
        bahan_rows.append(bahan)

    for i in range(len(list(menu.values())[0])):
        temp_harga = 0
        for j in range(len(menus)):
            temp_harga += menu[menus[j]][i] * list_harga[j]
        total_harga.append(temp_harga)


# Get all unique keys
    all_keys = set()
    for d in bahan_rows:
        all_keys.update(d.keys())

    # Create new dictionary with list values
    bahan_final = {key: [d.get(key, 0) for d in bahan_rows] for key in all_keys}
    bahan_final["total_harga"] = total_harga

    result = menu | bahan_final
    return result

def format_preparation(df):
    # hitung total harga
    total_harga = df.assign(total=lambda x: x['porsi'] * x['harga']).groupby('date')['total'].first().reset_index()
    # hitung kuantitas total
    df['kuantitas_total'] = df['kuantitas_bahan'] * df['porsi']

    menu_prep = df.pivot_table(
        index='date',
        columns='menu',
        values='porsi',
        aggfunc='first',
        fill_value=0
    )

    bahan_prep = df.pivot_table(
        index='date',
        columns='nama_bahan',
        values='kuantitas_total',
        aggfunc='sum',
        fill_value=0
    )

    preparation_formatted = pd.merge(
        menu_prep.reset_index(),
        bahan_prep.reset_index(),
        on='date'
    )

    preparation_formatted = pd.merge(
        preparation_formatted,
        total_harga.rename(columns={'total': 'total_harga'}),
        on='date'
    )
    
    preparation_formatted.fillna(0)
    menu_count = df['menu'].nunique()
    bahan_count = df['nama_bahan'].nunique()

    # debugging
    # print(menu_prep.head())
    # print(bahan_prep)
    # print(preparation_formatted.head())
    return preparation_formatted, menu_count, bahan_count

def fetch_cuaca(kelurahan):
    pass

def load_df(restaurant_id):
    global rest_id
    rest_id = restaurant_id

    # kelurahan = fetch_kelurahan()
    df_prep = fetch_preparation()
    df_prep, menu_count, bahan_count = format_preparation(df_prep)
    df_waste = fetch_waste()
    # df_cuaca = fetch_cuaca(kelurahan)

    df_merged = pd.merge(df_prep, df_waste, on='date', how='left')

    # print(df_merged)
    # print(menu_count)
    # print(bahan_count)
    return df_merged, menu_count, bahan_count