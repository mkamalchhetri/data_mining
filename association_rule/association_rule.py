import pandas as pd
import numpy as np
import matplotlib.pyplot as plt



# Reading CSV File
data = pd.read_csv("../data/mushrooms.csv")


def read_data():
    print(data.head())
    # Number of CLasses Counts
    print(data['type'].value_counts())


def order_analysis():
    # Getting all Poisonous Mushroom odor
    poisonous_Odor = data[data['type'] == 'p']['odor'].value_counts()

    # Showing With Pie Chart Poisonous_Odor
    poisonous_Odor.plot(kind='pie', figsize=(7, 7), legend=True, fontsize=10,
                        autopct='%.2f', title='Poisonous Mushroom with their Odor')
    plt.show()
    # Getting all Edible Mushroom odor
    Edible_Odor = data[data['type'] == 'e']['odor'].value_counts()

    # Showing with Pie Chart Edible_Odor
    Edible_Odor.plot(kind='pie', figsize=(7, 7), legend=True, fontsize=10,
                     autopct='%.2f', title='Edible Mushroom with their Odor')
    plt.show()


# Another feature to consider when identifying mushrooms is whether they bruise or bleed a specific color
def bruises():
    # Bruises Mushrooms :
    # t: Bruises:True
    # f: No Bruises: False
    poisonous_bruises = data[data['type'] == 'p']['bruises'].value_counts()
    edible_bruises = data[data['type'] == 'e']['bruises'].value_counts()

    Bruises = pd.DataFrame([poisonous_bruises, edible_bruises],
                           index=['Poisonous', 'Edible'])
    Bruises.plot(kind='barh', stacked=True, )
    plt.show()
    # In edible: bruises is more
    # In Poisonous: No Bruises is more


def habitat_analysis():
    # Analysing Habitat for Edible Mushroom:
    edible_habitate = data[data['class'] == 'e']['habitat'].value_counts()
    edible_habitate.plot(kind='pie', figsize=(7, 7), legend=True, fontsize=10,
                         autopct='%.2f')
    plt.show()

    # Analysing Habitat for Poisonous Mushroom:
    poisonous_habitate = data[data['class'] == 'p']['habitat'].value_counts()
    poisonous_habitate.plot(kind='pie', figsize=(7, 7), legend=True, fontsize=10,
                            autopct='%.2f')
    plt.show()

    # Vice Versa plot
    habit = pd.DataFrame([edible_habitate, poisonous_habitate], index=['Edible', 'Poisonous'])
    habit = habit.transpose()
    habit.plot(kind='bar', figsize=(7, 7))
    plt.show()


if __name__ == '__main__':
    bruises()
    print(data)
