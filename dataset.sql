INSERT INTO Restaurant (restaurant_id, nama, email, password, alamat_resmi, kelurahan_id)
VALUES (
    1000,
    'Random Restaurant',
    'random@example.com',
    'passwordhash123',
    '123 Random Street, City',
    1
);

INSERT INTO Menu (menu_id, nama, harga, restaurant_id, berat) 
VALUES
    (1000, 'Menu Item 1', 10000, 1000, 500),
    (1001, 'Menu Item 2', 12000, 1000, 500),
    (1002, 'Menu Item 3', 15000, 1000, 500),
    (1003, 'Menu Item 4', 13000, 1000, 500),
    (1004, 'Menu Item 5', 14000, 1000, 500),
    (1005, 'Menu Item 6', 16000, 1000, 500),
    (1006, 'Menu Item 7', 11000, 1000, 500),
    (1007, 'Menu Item 8', 12500, 1000, 500),
    (1008, 'Menu Item 9', 13500, 1000, 500),
    (1009, 'Menu Item 10', 14500, 1000, 500),
    (1010, 'Menu Item 11', 15500, 1000, 500),
    (1011, 'Menu Item 12', 16500, 1000, 500),
    (1012, 'Menu Item 13', 17500, 1000, 500),
    (1013, 'Menu Item 14', 18500, 1000, 500),
    (1014, 'Menu Item 15', 19500, 1000, 500);

INSERT INTO Bahan (bahan_id, nama, restaurant_id) 
VALUES
    (1000, 'Bahan 1', 1000),
    (1001, 'Bahan 2', 1000),
    (1002, 'Bahan 3', 1000),
    (1003, 'Bahan 4', 1000),
    (1004, 'Bahan 5', 1000),
    (1005, 'Bahan 6', 1000),
    (1006, 'Bahan 7', 1000),
    (1007, 'Bahan 8', 1000),
    (1008, 'Bahan 9', 1000),
    (1009, 'Bahan 10', 1000),
    (1010, 'Bahan 11', 1000),
    (1011, 'Bahan 12', 1000),
    (1012, 'Bahan 13', 1000),
    (1013, 'Bahan 14', 1000),
    (1014, 'Bahan 15', 1000);

-- Menu 1000 with random bahan
INSERT INTO Bahan_Menu (menu_id, bahan_id, kuantitas) VALUES
    (1000, 1000, 3),
    (1000, 1001, 7),
    (1000, 1002, 2),
    (1000, 1003, 5),
    (1000, 1005, 9),
    (1000, 1007, 4);

-- Menu 1001 with random bahan
INSERT INTO Bahan_Menu (menu_id, bahan_id, kuantitas) VALUES
    (1001, 1001, 6),
    (1001, 1003, 8),
    (1001, 1004, 3),
    (1001, 1006, 5),
    (1001, 1008, 2),
    (1001, 1010, 7);

-- Menu 1002 with random bahan
INSERT INTO Bahan_Menu (menu_id, bahan_id, kuantitas) VALUES
    (1002, 1002, 9),
    (1002, 1005, 1),
    (1002, 1007, 4),
    (1002, 1008, 3),
    (1002, 1011, 6);

-- Menu 1003 with random bahan
INSERT INTO Bahan_Menu (menu_id, bahan_id, kuantitas) VALUES
    (1003, 1000, 2),
    (1003, 1002, 5),
    (1003, 1004, 8),
    (1003, 1006, 4),
    (1003, 1009, 3),
    (1003, 1012, 7),
    (1003, 1014, 6);

-- Menu 1004 with random bahan
INSERT INTO Bahan_Menu (menu_id, bahan_id, kuantitas) VALUES
    (1004, 1001, 3),
    (1004, 1003, 6),
    (1004, 1005, 8),
    (1004, 1007, 2),
    (1004, 1009, 5);

-- Menu 1005 with random bahan
INSERT INTO Bahan_Menu (menu_id, bahan_id, kuantitas) VALUES
    (1005, 1004, 7),
    (1005, 1006, 2),
    (1005, 1008, 4),
    (1005, 1010, 5),
    (1005, 1012, 6),
    (1005, 1013, 9);

-- Menu 1006 with random bahan
INSERT INTO Bahan_Menu (menu_id, bahan_id, kuantitas) VALUES
    (1006, 1000, 4),
    (1006, 1002, 6),
    (1006, 1004, 3),
    (1006, 1005, 5),
    (1006, 1006, 7),
    (1006, 1009, 8),
    (1006, 1011, 2),
    (1006, 1013, 1);

-- Menu 1007 with random bahan
INSERT INTO Bahan_Menu (menu_id, bahan_id, kuantitas) VALUES
    (1007, 1001, 9),
    (1007, 1003, 2),
    (1007, 1005, 4),
    (1007, 1008, 6),
    (1007, 1010, 3),
    (1007, 1012, 8);

-- Menu 1008 with random bahan
INSERT INTO Bahan_Menu (menu_id, bahan_id, kuantitas) VALUES
    (1008, 1000, 7),
    (1008, 1004, 2),
    (1008, 1005, 5),
    (1008, 1006, 8),
    (1008, 1009, 4),
    (1008, 1013, 6);

-- Menu 1009 with random bahan
INSERT INTO Bahan_Menu (menu_id, bahan_id, kuantitas) VALUES
    (1009, 1002, 3),
    (1009, 1005, 8),
    (1009, 1007, 6),
    (1009, 1008, 2),
    (1009, 1011, 4);

-- Menu 1010 with random bahan
INSERT INTO Bahan_Menu (menu_id, bahan_id, kuantitas) VALUES
    (1010, 1001, 5),
    (1010, 1003, 7),
    (1010, 1006, 3),
    (1010, 1009, 6),
    (1010, 1012, 2);

-- Menu 1011 with random bahan
INSERT INTO Bahan_Menu (menu_id, bahan_id, kuantitas) VALUES
    (1011, 1000, 8),
    (1011, 1003, 5),
    (1011, 1006, 4),
    (1011, 1009, 3),
    (1011, 1011, 7),
    (1011, 1014, 2);

-- Menu 1012 with random bahan
INSERT INTO Bahan_Menu (menu_id, bahan_id, kuantitas) VALUES
    (1012, 1002, 9),
    (1012, 1004, 4),
    (1012, 1006, 1),
    (1012, 1008, 5),
    (1012, 1010, 6);

-- Menu 1013 with random bahan
INSERT INTO Bahan_Menu (menu_id, bahan_id, kuantitas) VALUES
    (1013, 1001, 7),
    (1013, 1004, 3),
    (1013, 1006, 8),
    (1013, 1009, 2),
    (1013, 1011, 6),
    (1013, 1013, 5);

-- Menu 1014 with random bahan
INSERT INTO Bahan_Menu (menu_id, bahan_id, kuantitas) VALUES
    (1014, 1003, 9),
    (1014, 1005, 7),
    (1014, 1007, 4),
    (1014, 1008, 3),
    (1014, 1010, 2),
    (1014, 1014, 5);

-- Insert preparations for the past 30 days with restaurant_id = 1000
INSERT INTO Preparation (preparation_id, date, restaurant_id) VALUES
    (1000, '2024-10-04', 1000),
    (1001, '2024-10-05', 1000),
    (1002, '2024-10-06', 1000),
    (1003, '2024-10-07', 1000),
    (1004, '2024-10-08', 1000),
    (1005, '2024-10-09', 1000),
    (1006, '2024-10-10', 1000),
    (1007, '2024-10-11', 1000),
    (1008, '2024-10-12', 1000),
    (1009, '2024-10-13', 1000),
    (1010, '2024-10-14', 1000),
    (1011, '2024-10-15', 1000),
    (1012, '2024-10-16', 1000),
    (1013, '2024-10-17', 1000),
    (1014, '2024-10-18', 1000),
    (1015, '2024-10-19', 1000),
    (1016, '2024-10-20', 1000),
    (1017, '2024-10-21', 1000),
    (1018, '2024-10-22', 1000),
    (1019, '2024-10-23', 1000),
    (1020, '2024-10-24', 1000),
    (1021, '2024-10-25', 1000),
    (1022, '2024-10-26', 1000),
    (1023, '2024-10-27', 1000),
    (1024, '2024-10-28', 1000),
    (1025, '2024-10-29', 1000),
    (1026, '2024-10-30', 1000),
    (1027, '2024-10-31', 1000),
    (1028, '2024-11-01', 1000),
    (1029, '2024-11-02', 1000),
    (1030, '2024-11-03', 1000);

-- Preparation 1000 (2024-10-04)
INSERT INTO Preparation_Item (preparation_id, menu_id, porsi) VALUES
    (1000, 1000, 8),
    (1000, 1001, 15),
    (1000, 1003, 12),
    (1000, 1005, 10),
    (1000, 1007, 6),
    (1000, 1010, 14),
    (1000, 1012, 9);

-- Preparation 1001 (2024-10-05)
INSERT INTO Preparation_Item (preparation_id, menu_id, porsi) VALUES
    (1001, 1001, 7),
    (1001, 1002, 13),
    (1001, 1004, 11),
    (1001, 1006, 5),
    (1001, 1008, 8),
    (1001, 1011, 16),
    (1001, 1013, 12),
    (1001, 1014, 10);

-- Preparation 1002 (2024-10-06)
INSERT INTO Preparation_Item (preparation_id, menu_id, porsi) VALUES
    (1002, 1000, 14),
    (1002, 1003, 9),
    (1002, 1005, 7),
    (1002, 1007, 5),
    (1002, 1009, 11),
    (1002, 1012, 18);

-- Preparation 1003 (2024-10-07)
INSERT INTO Preparation_Item (preparation_id, menu_id, porsi) VALUES
    (1003, 1000, 12),
    (1003, 1002, 6),
    (1003, 1004, 10),
    (1003, 1006, 7),
    (1003, 1009, 15),
    (1003, 1011, 9),
    (1003, 1014, 11);

-- Preparation 1004 (2024-10-08)
INSERT INTO Preparation_Item (preparation_id, menu_id, porsi) VALUES
    (1004, 1001, 10),
    (1004, 1003, 13),
    (1004, 1005, 8),
    (1004, 1006, 6),
    (1004, 1007, 15),
    (1004, 1009, 10),
    (1004, 1013, 7);

-- Preparation 1005 (2024-10-09)
INSERT INTO Preparation_Item (preparation_id, menu_id, porsi) VALUES
    (1005, 1002, 8),
    (1005, 1004, 14),
    (1005, 1005, 12),
    (1005, 1007, 11),
    (1005, 1009, 9),
    (1005, 1010, 15);

-- Preparation 1006 (2024-10-10)
INSERT INTO Preparation_Item (preparation_id, menu_id, porsi) VALUES
    (1006, 1000, 6),
    (1006, 1002, 10),
    (1006, 1005, 13),
    (1006, 1007, 9),
    (1006, 1008, 12),
    (1006, 1011, 5),
    (1006, 1013, 14);

-- Preparation 1007 (2024-10-11)
INSERT INTO Preparation_Item (preparation_id, menu_id, porsi) VALUES
    (1007, 1001, 11),
    (1007, 1003, 7),
    (1007, 1004, 10),
    (1007, 1006, 12),
    (1007, 1009, 6),
    (1007, 1012, 14),
    (1007, 1014, 9);

-- Preparation 1008 (2024-10-12)
INSERT INTO Preparation_Item (preparation_id, menu_id, porsi) VALUES
    (1008, 1000, 7),
    (1008, 1002, 8),
    (1008, 1004, 11),
    (1008, 1006, 14),
    (1008, 1008, 5),
    (1008, 1010, 12),
    (1008, 1013, 10);

-- Preparation 1009 (2024-10-13)
INSERT INTO Preparation_Item (preparation_id, menu_id, porsi) VALUES
    (1009, 1001, 12),
    (1009, 1002, 7),
    (1009, 1003, 9),
    (1009, 1005, 6),
    (1009, 1008, 10),
    (1009, 1011, 14),
    (1009, 1014, 8);

-- Preparation 1010 (2024-10-14)
INSERT INTO Preparation_Item (preparation_id, menu_id, porsi) VALUES
    (1010, 1002, 9),
    (1010, 1004, 13),
    (1010, 1006, 8),
    (1010, 1009, 6),
    (1010, 1011, 12),
    (1010, 1013, 7);

-- Preparation 1011 (2024-10-15)
INSERT INTO Preparation_Item (preparation_id, menu_id, porsi) VALUES
    (1011, 1000, 11),
    (1011, 1001, 10),
    (1011, 1004, 5),
    (1011, 1005, 12),
    (1011, 1006, 9),
    (1011, 1007, 14);

-- Preparation 1012 (2024-10-16)
INSERT INTO Preparation_Item (preparation_id, menu_id, porsi) VALUES
    (1012, 1003, 13),
    (1012, 1005, 8),
    (1012, 1006, 12),
    (1012, 1008, 9),
    (1012, 1009, 6),
    (1012, 1011, 15),
    (1012, 1013, 5);

-- Preparation 1013 (2024-10-17)
INSERT INTO Preparation_Item (preparation_id, menu_id, porsi) VALUES
    (1013, 1000, 8),
    (1013, 1003, 14),
    (1013, 1004, 10),
    (1013, 1006, 5),
    (1013, 1007, 12),
    (1013, 1009, 6),
    (1013, 1012, 7);

-- Preparation 1014 (2024-10-18)
INSERT INTO Preparation_Item (preparation_id, menu_id, porsi) VALUES
    (1014, 1002, 12),
    (1014, 1003, 6),
    (1014, 1005, 8),
    (1014, 1007, 14),
    (1014, 1008, 9),
    (1014, 1010, 13);

-- Add more entries similarly up to preparation 1030
-- Preparation 1015 (2024-10-19)
INSERT INTO Preparation_Item (preparation_id, menu_id, porsi) VALUES
    (1015, 1001, 9),
    (1015, 1002, 15),
    (1015, 1003, 8),
    (1015, 1005, 6),
    (1015, 1007, 11),
    (1015, 1009, 12),
    (1015, 1010, 7);

-- Preparation 1016 (2024-10-20)
INSERT INTO Preparation_Item (preparation_id, menu_id, porsi) VALUES
    (1016, 1000, 8),
    (1016, 1003, 10),
    (1016, 1005, 7),
    (1016, 1006, 13),
    (1016, 1008, 15),
    (1016, 1011, 6);

-- Preparation 1017 (2024-10-21)
INSERT INTO Preparation_Item (preparation_id, menu_id, porsi) VALUES
    (1017, 1000, 12),
    (1017, 1001, 6),
    (1017, 1004, 9),
    (1017, 1005, 5),
    (1017, 1006, 14),
    (1017, 1010, 11),
    (1017, 1012, 7);

-- Preparation 1018 (2024-10-22)
INSERT INTO Preparation_Item (preparation_id, menu_id, porsi) VALUES
    (1018, 1002, 10),
    (1018, 1003, 8),
    (1018, 1005, 11),
    (1018, 1006, 13),
    (1018, 1008, 7),
    (1018, 1011, 9);

-- Preparation 1019 (2024-10-23)
INSERT INTO Preparation_Item (preparation_id, menu_id, porsi) VALUES
    (1019, 1000, 9),
    (1019, 1003, 5),
    (1019, 1004, 8),
    (1019, 1006, 7),
    (1019, 1009, 11),
    (1019, 1013, 10),
    (1019, 1014, 12);

-- Preparation 1020 (2024-10-24)
INSERT INTO Preparation_Item (preparation_id, menu_id, porsi) VALUES
    (1020, 1001, 13),
    (1020, 1002, 10),
    (1020, 1004, 9),
    (1020, 1005, 6),
    (1020, 1007, 12),
    (1020, 1010, 5),
    (1020, 1011, 14);

-- Preparation 1021 (2024-10-25)
INSERT INTO Preparation_Item (preparation_id, menu_id, porsi) VALUES
    (1021, 1002, 7),
    (1021, 1004, 10),
    (1021, 1005, 13),
    (1021, 1006, 6),
    (1021, 1008, 11),
    (1021, 1012, 14);

-- Preparation 1022 (2024-10-26)
INSERT INTO Preparation_Item (preparation_id, menu_id, porsi) VALUES
    (1022, 1000, 8),
    (1022, 1002, 10),
    (1022, 1004, 7),
    (1022, 1007, 9),
    (1022, 1009, 12),
    (1022, 1011, 11),
    (1022, 1013, 5);

-- Preparation 1023 (2024-10-27)
INSERT INTO Preparation_Item (preparation_id, menu_id, porsi) VALUES
    (1023, 1001, 9),
    (1023, 1002, 8),
    (1023, 1005, 12),
    (1023, 1008, 14),
    (1023, 1010, 7);

-- Preparation 1024 (2024-10-28)
INSERT INTO Preparation_Item (preparation_id, menu_id, porsi) VALUES
    (1024, 1003, 11),
    (1024, 1004, 6),
    (1024, 1006, 9),
    (1024, 1008, 7),
    (1024, 1010, 5),
    (1024, 1011, 13),
    (1024, 1000, 10),
    (1024, 1001, 14),
    (1024, 1013, 8);

-- Preparation 1025 (2024-10-29)
INSERT INTO Preparation_Item (preparation_id, menu_id, porsi) VALUES
    (1025, 1000, 10),
    (1025, 1001, 14),
    (1025, 1004, 7),
    (1025, 1005, 9),
    (1025, 1006, 8),
    (1025, 1009, 11);

-- Preparation 1026 (2024-10-30)
INSERT INTO Preparation_Item (preparation_id, menu_id, porsi) VALUES
    (1026, 1001, 10),
    (1026, 1002, 12),
    (1026, 1003, 9),
    (1026, 1006, 6),
    (1026, 1008, 15),
    (1026, 1010, 13);

-- Preparation 1027 (2024-10-31)
INSERT INTO Preparation_Item (preparation_id, menu_id, porsi) VALUES
    (1027, 1003, 12),
    (1027, 1005, 6),
    (1027, 1007, 14),
    (1027, 1009, 9),
    (1027, 1011, 11);

-- Preparation 1028 (2024-11-01)
INSERT INTO Preparation_Item (preparation_id, menu_id, porsi) VALUES
    (1028, 1001, 13),
    (1028, 1003, 8),
    (1028, 1002, 10),
    (1028, 1004, 9),
    (1028, 1006, 8),
    (1028, 1007, 11),
    (1028, 1010, 14),
    (1028, 1013, 7);

-- Preparation 1029 (2024-11-02)
INSERT INTO Preparation_Item (preparation_id, menu_id, porsi) VALUES
    (1029, 1000, 8),
    (1029, 1002, 12),
    (1029, 1005, 10),
    (1029, 1006, 7),
    (1029, 1008, 11),
    (1029, 1012, 6);

-- Preparation 1030 (2024-11-03)
INSERT INTO Preparation_Item (preparation_id, menu_id, porsi) VALUES
    (1030, 1003, 9),
    (1030, 1004, 7),
    (1030, 1006, 12),
    (1030, 1007, 5),
    (1030, 1009, 8),
    (1030, 1011, 10),
    (1030, 1014, 11);

-- Waste for Preparation 1000 (2024-10-04)
INSERT INTO Waste (date, food_in_gr, restaurant_id) VALUES
    ('2024-10-04', FLOOR(RANDOM() * 25001), 1000);

-- Waste for Preparation 1001 (2024-10-05)
INSERT INTO Waste (date, food_in_gr, restaurant_id) VALUES
    ('2024-10-05', FLOOR(RANDOM() * 25001), 1000);

-- Waste for Preparation 1002 (2024-10-06)
INSERT INTO Waste (date, food_in_gr, restaurant_id) VALUES
    ('2024-10-06', FLOOR(RANDOM() * 25001), 1000);

-- Waste for Preparation 1003 (2024-10-07)
INSERT INTO Waste (date, food_in_gr, restaurant_id) VALUES
    ('2024-10-07', FLOOR(RANDOM() * 25001), 1000);

-- Waste for Preparation 1004 (2024-10-08)
INSERT INTO Waste (date, food_in_gr, restaurant_id) VALUES
    ('2024-10-08', FLOOR(RANDOM() * 25001), 1000);

-- Waste for Preparation 1005 (2024-10-09)
INSERT INTO Waste (date, food_in_gr, restaurant_id) VALUES
    ('2024-10-09', FLOOR(RANDOM() * 25001), 1000);

-- Waste for Preparation 1006 (2024-10-10)
INSERT INTO Waste (date, food_in_gr, restaurant_id) VALUES
    ('2024-10-10', FLOOR(RANDOM() * 25001), 1000);

-- Waste for Preparation 1007 (2024-10-11)
INSERT INTO Waste (date, food_in_gr, restaurant_id) VALUES
    ('2024-10-11', FLOOR(RANDOM() * 25001), 1000);

-- Waste for Preparation 1008 (2024-10-12)
INSERT INTO Waste (date, food_in_gr, restaurant_id) VALUES
    ('2024-10-12', FLOOR(RANDOM() * 25001), 1000);

-- Waste for Preparation 1009 (2024-10-13)
INSERT INTO Waste (date, food_in_gr, restaurant_id) VALUES
    ('2024-10-13', FLOOR(RANDOM() * 25001), 1000);

-- Waste for Preparation 1010 (2024-10-14)
INSERT INTO Waste (date, food_in_gr, restaurant_id) VALUES
    ('2024-10-14', FLOOR(RANDOM() * 25001), 1000);

-- Waste for Preparation 1011 (2024-10-15)
INSERT INTO Waste (date, food_in_gr, restaurant_id) VALUES
    ('2024-10-15', FLOOR(RANDOM() * 25001), 1000);

-- Waste for Preparation 1012 (2024-10-16)
INSERT INTO Waste (date, food_in_gr, restaurant_id) VALUES
    ('2024-10-16', FLOOR(RANDOM() * 25001), 1000);

-- Waste for Preparation 1013 (2024-10-17)
INSERT INTO Waste (date, food_in_gr, restaurant_id) VALUES
    ('2024-10-17', FLOOR(RANDOM() * 25001), 1000);

-- Waste for Preparation 1014 (2024-10-18)
INSERT INTO Waste (date, food_in_gr, restaurant_id) VALUES
    ('2024-10-18', FLOOR(RANDOM() * 25001), 1000);

-- Waste for Preparation 1015 (2024-10-19)
INSERT INTO Waste (date, food_in_gr, restaurant_id) VALUES
    ('2024-10-19', FLOOR(RANDOM() * 25001), 1000);

-- Waste for Preparation 1016 (2024-10-20)
INSERT INTO Waste (date, food_in_gr, restaurant_id) VALUES
    ('2024-10-20', FLOOR(RANDOM() * 25001), 1000);

-- Waste for Preparation 1017 (2024-10-21)
INSERT INTO Waste (date, food_in_gr, restaurant_id) VALUES
    ('2024-10-21', FLOOR(RANDOM() * 25001), 1000);

-- Waste for Preparation 1018 (2024-10-22)
INSERT INTO Waste (date, food_in_gr, restaurant_id) VALUES
    ('2024-10-22', FLOOR(RANDOM() * 25001), 1000);

-- Waste for Preparation 1019 (2024-10-23)
INSERT INTO Waste (date, food_in_gr, restaurant_id) VALUES
    ('2024-10-23', FLOOR(RANDOM() * 25001), 1000);

-- Waste for Preparation 1020 (2024-10-24)
INSERT INTO Waste (date, food_in_gr, restaurant_id) VALUES
    ('2024-10-24', FLOOR(RANDOM() * 25001), 1000);

-- Waste for Preparation 1021 (2024-10-25)
INSERT INTO Waste (date, food_in_gr, restaurant_id) VALUES
    ('2024-10-25', FLOOR(RANDOM() * 25001), 1000);

-- Waste for Preparation 1022 (2024-10-26)
INSERT INTO Waste (date, food_in_gr, restaurant_id) VALUES
    ('2024-10-26', FLOOR(RANDOM() * 25001), 1000);

-- Waste for Preparation 1023 (2024-10-27)
INSERT INTO Waste (date, food_in_gr, restaurant_id) VALUES
    ('2024-10-27', FLOOR(RANDOM() * 25001), 1000);

-- Waste for Preparation 1024 (2024-10-28)
INSERT INTO Waste (date, food_in_gr, restaurant_id) VALUES
    ('2024-10-28', FLOOR(RANDOM() * 25001), 1000);

-- Waste for Preparation 1025 (2024-10-29)
INSERT INTO Waste (date, food_in_gr, restaurant_id) VALUES
    ('2024-10-29', FLOOR(RANDOM() * 25001), 1000);

-- Waste for Preparation 1026 (2024-10-30)
INSERT INTO Waste (date, food_in_gr, restaurant_id) VALUES
    ('2024-10-30', FLOOR(RANDOM() * 25001), 1000);

-- Waste for Preparation 1027 (2024-10-31)
INSERT INTO Waste (date, food_in_gr, restaurant_id) VALUES
    ('2024-10-31', FLOOR(RANDOM() * 25001), 1000);

-- Waste for Preparation 1028 (2024-11-01)
INSERT INTO Waste (date, food_in_gr, restaurant_id) VALUES
    ('2024-11-01', FLOOR(RANDOM() * 25001), 1000);

-- Waste for Preparation 1029 (2024-11-02)
INSERT INTO Waste (date, food_in_gr, restaurant_id) VALUES
    ('2024-11-02', FLOOR(RANDOM() * 25001), 1000);

-- Waste for Preparation 1030 (2024-11-03)
INSERT INTO Waste (date, food_in_gr, restaurant_id) VALUES
    ('2024-11-03', FLOOR(RANDOM() * 25001), 1000);




