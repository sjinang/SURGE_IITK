ind = 0
rn = 90
tr2=0
tmdabse=0
tabse=0
while ind < 10:
    f = open('o2.txt', 'r')

    rows = []
    cyc = []
    for line in f:
        # Split on any whitespace (including tab characters)
        row = line.split()
        # Convert strings to numeric values:
        row[0] = float(row[0])
        row[1] = float(row[1])
        row[2] = float(row[2])
        row[3] = float(row[3])
        row[4] = float(row[4])
        row[5] = float(row[5])
        row[6] = float(row[6])
        row[7] = float(row[7])
        row[8] = float(row[8])
        row[9] = float(row[9])
        row[10] = float(row[10])
        row[11] = float(row[11])
        # Append to our list of lists:
        rows.append(row)
    #f1 = open('res.txt','r')
    
    from sklearn import preprocessing
    #from pandas import DataFrame
    import numpy as np
    import panda as pd
    from sklearn.neural_network import MLPRegressor
    #import statsmodels.api as sm
    from sklearn.model_selection import train_test_split  
    #from sklearn.datasets import load_boston  
    from sklearn.metrics import r2_score, mean_absolute_error  
    #rows = preprocessing.normalize(rows)

    cols = list(zip(*rows))
    
    #cols[0] = [(float(i)-min(cols[0]))/(max(cols[0])-min(cols[0])) for i in cols[0]]
    #cols[1] = [(float(i)-min(cols[1]))/(max(cols[1])-min(cols[1])) for i in cols[1]]
    #cols[2] = [(float(i)-min(cols[2]))/(max(cols[2])-min(cols[2])) for i in cols[2]]
    #cols[3] = [(float(i)-min(cols[3]))/(max(cols[3])-min(cols[3])) for i in cols[3]]
    cols[4] = [(float(i)-min(cols[4]))/(max(cols[4])-min(cols[4])) for i in cols[4]]
    cols[5] = [(float(i)-min(cols[5]))/(max(cols[5])-min(cols[5])) for i in cols[5]]
    cols[6] = [(float(i)-min(cols[6]))/(max(cols[6])-min(cols[6])) for i in cols[6]]
    cols[7] = [(float(i)-min(cols[7]))/(max(cols[7])-min(cols[7])) for i in cols[7]]
    cols[8] = [(float(i)-min(cols[8]))/(max(cols[8])-min(cols[8])) for i in cols[8]]
    cols[9] = [(float(i)-min(cols[9]))/(max(cols[9])-min(cols[9])) for i in cols[9]]
    cols[10] = [(float(i)-min(cols[10]))/(max(cols[10])-min(cols[10])) for i in cols[10]]
    cols[11] = [(float(i)-min(cols[11]))/(max(cols[11])-min(cols[11])) for i in cols[11]]
    
    X1 = cols[0:11]
    X = list(zip(*X1))
    Y = cols[11]
    #print(X[0])
    
    X_train, X_test, y_train, y_test = train_test_split(X, Y, test_size = 0.2, random_state=rn) 
    
   # print(y_test)

    lin_reg_mod = MLPRegressor(solver='lbfgs',activation='logistic',max_iter=2000,learning_rate='adaptive',hidden_layer_sizes=(500,),random_state=1)
    
    lin_reg_mod.fit(X_train, y_train)  
    pred = lin_reg_mod.predict(X_test)
    #print(pred)
    #print(y_test)
    test_set_r2 = r2_score(y_test, pred)
    #print(test_set_r2)
    tr2+=test_set_r2
    
    #abs_er = mean_absolute_error(y_test, pred)
    #tabse+=abs_er

    temp = []
    for (i,j) in zip(y_test, pred):
        t = (abs(i-j))/float(i)
        temp.append(t)
    #print(temp)
    #print(np.median(temp))
    tmdabse+=np.median(temp)


    ind+=1
    rn-=10

print "r2 score",tr2/10.0
#print("mean absolute error",tabse/10.0)
print "median absolute percentage error",tmdabse/10.0
#print("if l2/max normalization is used MdAbsError=0.12")
