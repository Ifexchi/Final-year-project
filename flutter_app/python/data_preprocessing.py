import pandas as pd

df = pd.read_csv('tags.csv')
tag = []

for i in range(len(df)):
    if df['Tag'][i] == 'python':
        tag.append(df['Id'][i])

print(len(tag))

df = pd.read_csv('questions.csv', encoding='ISO-8859-1')
questions = []

for i in range(100000):
    if df['Id'][i] in tag:
        questions.append(df['Body'][i])

print(len(questions))

df = pd.read_csv('Answers.csv', encoding='ISO-8859-1')
answers = []

for i in range(300000):
    if df['Id'][i] in tag:
        answers.append(df['Body'][i])

dialogs = []
