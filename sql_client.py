#!/usr/bin/python3
import requests
import json
import sys
import os
import config as cfg
from datetime import datetime, time
import calendar
import re
import psycopg2



class SQLClient:

    def __init__(self, connection):
        self.connection = connection

    def make_sqlclient():
        connection = psycopg2.connect(host="127.0.0.1", port=55432, database="voxipo_db", user="voxipo_user",
                                      password=">>4_@EMaxT3Ah9p#")
        client = SQLClient(connection)
        client.connection = connection
        return client

    # >>4_@EMaxT3Ah9p#
    def create_entry(self, data):
        try:
            cursor = self.connection.cursor()
            query = "INSERT INTO voxipo.vote (continent, sub_continent, state, ruling_party_leader, political_position, thumbnail,picture_link, licence_text ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"
            print(query)
            print(data)
            cursor.execute(query, (data[0], data[1], data[2], data[3], data[4], data[5], data[6], data[7]))
            print("Foetzhen")
            cursor.close()
            # conn.close()
        except Exception as error:
            print("Oops! An exception has occured:", error)
            print("Exception TYPE:", type(error))

    def findCSV(self):
        file_names = []
        csvdir = '/tmp/csv/'
        #csvdir = cfg.appconfig['csvdirectory']
        for file in os.listdir(csvdir):
            if file.endswith(".csv"):
                file_names.append(os.path.join(csvdir, file))
                print(os.path.join(csvdir, file))
        return file_names