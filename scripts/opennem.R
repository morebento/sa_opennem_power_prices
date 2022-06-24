library(tidyverse)
library(janitor)
library(ggthemes)

opennem_tbl <- read_csv("20220601 South Australia.csv")

glimpse(opennem_tbl)

opennem_tbl %>% clean_names()

opennem_cleaned_tbl <- opennem_tbl %>% clean_names()

glimpse(opennem_cleaned_tbl)

opennem_cleaned_tbl %>%
    ggplot(aes(date, wind_mw)) +
    geom_line()

opennem_cleaned_tbl %>%
    select(date:solar_rooftop_mw) %>%
    gather("metric", "value", -date) %>%
    ggplot(aes(x=date, y=value, fill=metric)) +
    geom_area() 


opennem_cleaned_tbl %>%
    filter(price_aud_m_wh <= 2000) %>%
    ggplot(aes( price_aud_m_wh, wind_mw)) +
    geom_point()

opennem_cleaned_tbl %>%
    filter(price_aud_m_wh <= 2000) %>%
    select( -temperature_c, -emissions_intensity_kg_co2e_m_wh, -exports_mw) %>%
    gather("generation_type", "mw", -price_aud_m_wh, -date) %>%
    arrange(date, generation_type) %>%
    ggplot(aes(mw, price_aud_m_wh)) +
    geom_point(aes(colour=generation_type)) +
    facet_wrap(vars(generation_type), scales="free")

opennem_cleaned_tbl %>%
    filter(price_aud_m_wh <= 2000) %>%
    ggplot() +
    geom_histogram(aes(price_aud_m_wh))
