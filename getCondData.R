
# Function to download and subset Benefit Conditions & Sanctions Data



getCondData <- function(indicators=NULL,space=NULL,time=NULL){

require(dplyr)

# Checks
inds <- c("conditionality","conditions","sanctions","occup","wage","oth","jsr","vol","ref","rep","fail")
cntrs <- c("Australia","Austria","Belgium","Canada","Denmark","Finland","France","Germany","Greece",
             "Ireland","Italy","Japan","Korea","Netherlands","New Zealand","Norway","Portugal","Spain",
             "Sweden","Switzerland","United Kingdom")
yrs <- seq(from = 1980, to = 2012, by = 1)

if(!is.null(indicators) | !is.null(space) | !is.null(time)){ # If any args are used..
if(length(dplyr::setdiff(indicators,inds))!=0 | # ...checks if any error in selection;...
   length(dplyr::setdiff(space,cntrs))!=0 | # ...if yes, checks arg by arg and returns error where appropriate
   length(dplyr::setdiff(time,yrs))!=0){

if(length(dplyr::setdiff(indicators,inds))!=0){ # Check if non-existent indicators were selected
    message(paste0("It seems you might have misspelled something or selected one or more indicators that are not contained in the dataset. Please select one or more of the following indicators: 'conditionality','conditions','sanctions','occup','wage','oth','jsr','vol','ref','rep','fail' \n \n"))
}

if(length(dplyr::setdiff(space,cntrs))!=0){ # check if non-covered countries were selected
    message(paste0("It seems you might have misspelled something or selected one or more countries that are not covered by the dataset. Please select one or more of following countries: Australia, Austria, Belgium, Canada, Denmark, Finland, France, Germany, Greece, Ireland, Italy, Japan, Korea, Netherlands, New Zealand, Norway, Portugal, Spain, Sweden, Switzerland, United Kingdom \n \n"
                    ))
}

if(length(dplyr::setdiff(time,yrs))!=0) { # check if non-covered years were selected
    message(paste0("It seems you might have misspelled something or selected one or more years that are not covered by the dataset. Please select one or more years between 1980 and 2012."))
}
stop_quietly <- function() {
  opt <- options(show.error.messages = FALSE)
  on.exit(options(opt))
  stop()
}
stop_quietly()
}
}

# If check passed: Dataset is loaded and indicators are labeled
data <- read.csv(url("https://raw.githubusercontent.com/cknotz/benefitconditionalitydata/master/conddata.csv"))

# Subsetting - the 'meat part'
if(!is.null(indicators)){
data <- data %>%
    select(country,year,all_of(indicators))
}

if(!is.null(space)){
data <- data %>%
    filter(country %in% space)
}

if(!is.null(time)){
data <- data %>%
    filter(year %in% time)
}

# Return result
return(data)
}
