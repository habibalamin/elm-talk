module Subscription exposing (..)

import Keyboard

import Model.Presentation exposing (..)
import Action exposing (..)


subscriptions : Presentation -> Sub Action
subscriptions model =
  Keyboard.downs HitKey
