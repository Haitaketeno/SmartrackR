#CODE FOR JOURNEY TIMES TABLE
journey_times <- railRep  %>% arrange_('tripID','arrival') %>%
  group_by(tripID, type, direction, peak, Resource.Name) %>%
  summarise(Origin = first(origin), Destination = last(destination),
            Departure = first(departure), Arrival = last(arrival),
            TripTime = difftime(last(arrival),first(departure), tz = "AEST", units = "mins"),
            TrainTime = sum(AvgTrainTime),
            XtraTime = first(onTime), XtraTrain = sum(AvgTrainTimeInt),
            Date = as.Date(first(departure))) %>%
  group_by(type, peak, direction, Date) %>%
  mutate(Punctual = ifelse(((TripTime+XtraTrain) <= (TrainTime+XtraTime)),1,0)) %>%
  summarise(TravelTimes = mean(TripTime),
            Delay = mean((TripTime+XtraTrain)-TrainTime),
            AdditionalTravelTime = mean(XtraTime),
            Difference = mean((TripTime+XtraTrain) - (TrainTime+XtraTime)),
            Punctuality = sum(Punctual),
            NumBuses = n()) %>% arrange(Date)

journey_times$Punctuality <- round(journey_times$Punctuality / journey_times$NumBuses,2)
