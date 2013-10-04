import csv as csv
import re


def addTitle(csvLocation):
    csvInFile = csv.reader(open(csvLocation+'.csv', 'rb'))
    csvOutFile = csv.writer(open(csvLocation+'-title.csv', "wb"))

    header = csvInFile.next()
    header.append("Title")
    csvOutFile.writerow(header)

    for row in csvInFile:
        m = re.search("^.*,\s*(\w+)\..*$", row[3])
        if m == None:
            row.append(row[3])
        else:
            row.append(m.group(1))
        csvOutFile.writerow(row)



import sys
if __name__ == '__main__':
    if len(sys.argv) > 1:
        csvLocation = sys.argv[1].strip()
        addTitle(csvLocation)
    else:
        print 'This test requires an input file.  Please select one from the data directory. (i.e. python solver.py ./data/ks_4_0)'

