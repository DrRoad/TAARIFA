import pandas as pd

def pumps_within_radius(index, radius):
    '''
    given index in dataframe and radius in km
    return dataframe of pumps and status group within radius
    '''
    
    x = train.latitude[index]
    y = train.longitude[index]
    distance_2 = (train.latitude - x)**2 + (train.longitude - y)**2
    
    return train[distance_2 < ((1/111)*radius)**2] # Each degree of latitude is approx. 111 kilometers

def create_pump_counts(radius):
    '''
    given radius in km
    return train dataframe with count of pumps by status group as new feature
    '''
    
    # Create new columns
    for label in ['functional', 'nonfunctional', 'functionalneedsrepair']:
        train[label + "_" + str(radius) + 'km'] = ""
    
    # Count pumps within radius and return as feature
    for i in range(0, len(train)):
        
        pumps = pumps_within_radius(index = i, radius = radius)
        pumps_count = pumps.status_group.value_counts()

        try:
            train.at[i, 'functional' + '_' + str(radius) + 'km'] = pumps_count['functional']
        except:
            train.at[i, 'functional' + '_' + str(radius) + 'km'] = 0
            
        try:
            train.at[i, 'nonfunctional' + '_' + str(radius) + 'km'] = pumps_count['non functional']
        except:
            train.at[i, 'nonfunctional' + '_' + str(radius) + 'km'] = 0
       
        try:
            train.at[i, 'functionalneedsrepair' + '_' + str(radius) + 'km'] = pumps_count['functional needs repair']
        except:
            train.at[i, 'functionalneedsrepair' + '_' + str(radius) + 'km'] = 0
            
        if i % 100 == 0:
            print(str(i) + " done")
        


# Data prep
train = pd.read_csv('../Data/train_values.csv')
train_label = pd.read_csv('../Data/train_labels.csv')
train = pd.merge(train, train_label, how = 'left', on = 'id')
train = train.loc[:,['latitude', 'longitude', 'status_group', 'id']]

create_pump_counts(1)
create_pump_counts(2)
create_pump_counts(5)
create_pump_counts(10)