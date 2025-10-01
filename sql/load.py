import json
import mysql.connector


import json
import mysql.connector

conn = mysql.connector.connect(
    host="localhost",
    user="root",
    password="",
    database="festivals"
)

cursor = conn.cursor()


def import_data(filename, table, fields):
    print(f"Εισαγωγή από {filename} στον πίνακα {table}...")
    with open(filename, 'r', encoding='utf-8') as f:
        records = json.load(f)
        if isinstance(records, dict):
            records = list(records.values())[0]

    placeholders = ', '.join(['%s'] * len(fields))
    columns = ', '.join(fields)
    sql = f"INSERT INTO {table} ({columns}) VALUES ({placeholders})"

    successful = 0
    for i, record in enumerate(records):
        values = [record.get(field) for field in fields]
        try:
            cursor.execute(sql, values)
            successful += 1
        except mysql.Error as err:
            print(f"Σφάλμα στον πίνακα {table}, εγγραφή #{i + 1}: {err}")
            print("Δεδομένα:", record)
    conn.commit()
    print(f"{successful}/{len(records)} εγγραφές καταχωρήθηκαν στον πίνακα {table}.\n")


import_data("dummy_data/continent.json", "continent", ["name"])
import_data("dummy_data/location.json", "location", ['location_id', 'latitude', 'longitude', 'city', 'country', 'postal_code', 'street_number', 'street_name', 'continent_id'])
import_data("dummy_data/festivals.json", "festival", ['festival_id', 'name', 'start', 'end', 'location_id','image_url','image_description'])
import_data("dummy_data/stage.json", "stage", ['stage_id', 'stage_name', 'stage_description', 'capacity','image_url','image_description' ])
import_data("dummy_data/events.json", "event", ['event_id', 'event_name', 'event_date', 'start_time', 'end_time', 'festival_id', 'stage_id','image_url','image_description'])
import_data("dummy_data/equipment.json", "equipment", ['equipment_id', 'name','image_url','image_description'])
import_data("dummy_data/stage_equipment.json", "stage_equipment", ['stage_id', 'equipment_id'])
import_data("dummy_data/role.json", "role", ['role_id', 'role'])
import_data("dummy_data/experience.json", "experience", ['experience_id', 'experience'])
import_data("dummy_data/personel.json", "personel", ['personel_id', 'name', 'last_name', 'age', 'experience_id', 'role_id'])
import_data("dummy_data/stage_personel.json", "stage_personel", ['stage_id', 'personel_id'])
import_data("dummy_data/performance_kind.json", "performance_kind", ['kind'])
import_data("dummy_data/bands.json", "band", ['band_id', 'band_name', 'band_date_creation', 'band_website','image_url','image_description'])
import_data("dummy_data/performances.json", "performance", ["performance_name","performance_date","performance_start_time","performance_end_time","performance_duration","event_id","performance_kind_id","band_id",'image_url','image_description'])
import_data("dummy_data/artists.json", "artist", ['artist_id', 'artist_name','artist_surname', 'artist_pseudonym', 'artist_birthdate', 'artist_website', 'artist_insta','image_url','image_description'])
import_data("dummy_data/performance_artist.json", "performance_artist", ['performance_id', 'artist_id'])
import_data("dummy_data/artist_band.json", "artist_band", ['artist_id', 'band_id'])
import_data("dummy_data/music_genre.json", "music_genre", ['music_genre_id', 'music_genre','image_url','image_description'])
import_data("dummy_data/music_subgenre.json", "music_subgenre", ['music_subgenre_id', 'music_subgenre','image_url','image_description'])
import_data("dummy_data/artist_genre.json", "artist_genre", ['artist_id', 'music_genre_id'])
import_data("dummy_data/artist_subgenre.json", "artist_subgenre", ['artist_id', 'music_subgenre_id'])
import_data("dummy_data/band_genre.json", "band_genre", ['band_id', 'music_genre_id'])
import_data("dummy_data/band_subgenre.json", "band_subgenre", ['band_id', 'music_subgenre_id'])
import_data("dummy_data/ticket_category.json", "ticket_category", ['id_ticket_category', 'category_name'])
import_data("dummy_data/payment_method.json", "payment_method", ['id_payment_method', 'method_name'])
import_data("dummy_data/visitors.json", "visitor", ["first_name", "last_name", "phone", "email", "age"])
import_data("dummy_data/tickets.json", "ticket", ['code_ean13', 'purchase_date', 'purchase_time', 'for_sale', 'activated', 'cost', 'id_ticket_category', 'id_payment_method', 'event_id', 'id_visitor'])
import_data("dummy_data/buyers.json", "buyer", ['buyer_id', 'name', 'last_name', 'phone', 'email', 'age'])
import_data("dummy_data/buyer_queue.json", "buyer_queue", ['buyer_queue_id', 'event_id', 'id_ticket_category', 'code_ean13', 'timestamp', 'buyer_id'])
import_data("dummy_data/likert.json", "likert", ['likert_category'])
import_data("dummy_data/evaluations.json", "evaluation", ['artist_performance_rating','sound_and_light_rating','stage_presentation_rating', 'organization_rating',
'overall_impression_rating','id_visitor','performance_id'])

cursor.close()
conn.close()
print("Ολοκληρώθηκε η εισαγωγή όλων των αρχείων.")