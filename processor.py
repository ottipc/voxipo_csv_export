#!/usr/bin/python3
import datetime
import csv
import sql_client
import os
import time
postgres_client = sql_client.SQLClient.make_sqlclient()
files = postgres_client.findCSV()

# client.get_token()
for csvfile in files:
    with open(csvfile) as csv_file:
        processedLines = []
        try:
            csv_reader = csv.reader(csv_file, delimiter='\t')
            line_count = 0
            for row in csv_reader:
                if line_count == 0:
                    var = "Column names are {}".format(row)
                    print(var)
                    line_count += 1
                    continue
                else:
                    print("Processing ...")
                    print(row)
                    
                    #time.sleep(3)
                    if row[2] is not None:
                        processed = postgres_client.create_entry(row)
                        print("Processed :  {} ".format(processed))
                        #print('\t{row[0]} works in the {row[1]} department, and was born in {row[2]}.')
                        line_count += 1
        except csv.Error as ce:
            print('Exception importing {} : {} in Line : {}'.format(
                csvfile, str(e), line_count + 1))
            sys.exit()
            #actual_date = datetime.datetime.now().strftime("%d.%m.%Y-%H:%M:%S")
            #csvfilename = os.path.basename(csvfile).replace(
            #    '.csv', '.{}.csv'.format(actual_date))
            # move file to errorprocessed
            #os.rename(
            #    csvfile, "{}errorprocessed/{}".format(cfg.appconfig['csvdirectory'], csvfilename))
            #sql_client.sendMailError(csvfilename, "Error at Importing : {} : Line {}".format(
            #    str(ce), line_count + 1), processedLines)
            #print(" CSV Error {} : {} ".format(csvfile, ce.args))
            continue
        except Exception as e:
            print('Exception importing {} : {} in Line : {}'.format(
                csvfile, str(e), line_count + 1))
            sys.exit()
            #actual_date = datetime.datetime.now().strftime("%d.%m.%Y-%H:%M:%S")
            #csvfilename = os.path.basename(csvfile).replace(
            #    '.csv', '.{}.csv'.format(actual_date))
            # move file to errorprocessed
            #os.rename(
            #    csvfile, "{}/errorprocessed/{}".format(cfg.appconfig['csvdirectory'], csvfilename))
            #client.sendMailError(csvfilename, "Error at Importing : {} : Line {}".format(
            #    str(e), line_count + 1), processedLines)
            continue
        postgres_client.connection.commit()
        postgres_client.connection.close()
        print('Processed {} lines.'.format(line_count))

        #actual_date = datetime.datetime.now().strftime("%d.%m.%Y%I-%H:%M:%S")
        #csvfilename = os.path.basename(csvfile).replace(
        #    '.csv', '.{}.csv'.format(actual_date))
        # move file to processed
        #os.rename(
        #    csvfile, "{}/processed/{}".format(cfg.appconfig['csvdirectory'], csvfilename))
        #client.sendMailCorrect(csvfilename, processedLines)
