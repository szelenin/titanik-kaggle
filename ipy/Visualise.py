import matplotlib.pyplot as plt

class Graphs:
    def __init__(self, df):
        self.df = df

    def show(self):
        ###########################################################################
        # Plot graphs
        ###########################################################################
        fig = plt.figure(figsize=(18,6)) # specifies the parameters of our graphs
        a = 0.2                                   # sets the alpha level of the colors in the graph (for more attractive results)
        a_bar = 0.55                              # another alpha setting

        plt.subplot2grid((2,3),(0,0))             # lets us plot many diffrent shaped graphs together
        self.df.Survived.value_counts().plot(kind='bar', alpha=a_bar)# plots a bar graph of those who surived vs those who did not.
        plt.title("Distribution of Survival, (1 = Survived)") # puts a title on our graph

        plt.subplot2grid((2,3),(0,1))
        plt.scatter(self.df.Survived, self.df.Age, alpha=a)
        plt.ylabel("Age")                         # sets the y axis lable
        plt.grid(b=True, which='major', axis='y') # formats the grid line style of our graphs
        plt.title("Survial by Age,  (1 = Survived)")

        plt.subplot2grid((2,3),(0,2))
        self.df.Pclass.value_counts().plot(kind="barh", alpha=a_bar)
        plt.title("Class Distribution")

        plt.subplot2grid((2,3),(1,0), colspan=2)
        self.df.Age[self.df.Pclass == 1].plot(kind='kde')   # plots a kernel desnsity estimate of the subset of the 1st class passanges's age
        self.df.Age[self.df.Pclass == 2].plot(kind='kde')
        self.df.Age[self.df.Pclass == 3].plot(kind='kde')
        plt.xlabel("Age")                         # plots an axis lable
        plt.title("Age Distribution within classes")
        plt.legend(('1st Class', '2nd Class','3rd Class'),loc='best') # sets our legend for our graph.

        plt.subplot2grid((2,3),(1,2))
        self.df.Embarked.value_counts().plot(kind='bar', alpha=a_bar)
        plt.title("Passengers per boarding location")

        plt.show()