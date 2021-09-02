#Workshop 3 
library(tidymodels)
library(skimr)
library(janitor)
library(dplyr)

muffin_cupcake_original <- 
  read.csv("https://raw.githubusercontent.com/adashofdata/muffin-cupcake/master/recipes_muffins_cupcakes.csv")

#ckean variable names with the janitor package 

muf_cup <- muffin_cupcake_original%>%
  clean_names()
#all names were replaced only with the lowercase versions
 
mc_split<-initial_split(muf_cup)
mc_train<-training(mc_split)
mc_tet<-testing(mc_split)

model_recipe<-recipe(type~flour+milk+sugar+butter+egg,
                     data = mc_train)

model_recipe_steps<- model_recipe%>%
  step_mutate()
  #mean impute all numeric variables
  step_meanimpute(all_numeric())%>%
  step_nzv(all_predictors())
  
prepped_recipe<-prep(model_recipe_steps, 
                     training = mc_train)

mc_train_prepro<- bake(prepped_recipe, mc_train)
mc_test_prepro<-bake(prepped_recipe, mc_tet)

