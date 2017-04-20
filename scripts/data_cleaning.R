### Data processing
dir.data = "~\\DataScienceCourse\\ProgrammingAssignment9\\data_raw\\"
filename.data = "autos.csv"

df.raw <- read.csv(paste0(dir.data, filename.data))
df.temp <- df.raw[,c(4:5,7:10,12,14,16)]

### Remove damaged cars, cars with a price less than 100 euros or higher than 99999 euro,
### cars that are not offered, cars that don't have petrol or diesel as fuel, etc.
df.temp <- df.temp[df.temp$notRepairedDamage=="nein",]
df.temp <- df.temp[df.temp$price > 99,]
df.temp <- df.temp[df.temp$price < 99999,]
df.temp <- df.temp[df.temp$offerType == "Angebot",]
df.temp <- df.temp[df.temp$fuelType %in% c("benzin","diesel"),]
df.temp <- df.temp[df.temp$vehicleType %in% c("cabrio", "coupe", "kleinwagen", "suv"),]
levels(df.temp$vehicleType) <- c("","andere","bus","cabrio","coupe","compact","combi","luxury","suv")
df.temp <- df.temp[df.temp$powerPS > 0,]
df.temp <- df.temp[df.temp$powerPS < 1000,]
df.temp <- df.temp[df.temp$gearbox !="",]
df.temp$age <- 2017 - df.temp$yearOfRegistration
df.out <- df.temp[,c(2:3,5:8,10)]

### Save the clean data set
write.csv(df.out, paste0(dir.data,"tidy.csv"))
