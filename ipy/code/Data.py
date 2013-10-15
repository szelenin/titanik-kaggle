import pandas as pd
import re

class Data:
    def __init__(self, csvFile):
        self.df = pd.read_csv(csvFile)

    def addTitle(self):
        def getTitle(name):
            m = re.search("^.*,\s*(\w+)\..*$", name)
            if m != None:
                return m.group(1)
            return name

        self.df["Title"] = self.df["Name"]
        self.df["Title"] = self.df["Title"].apply(getTitle)

    def title(self, rowNum):
        return self.df["Title"].loc[rowNum]