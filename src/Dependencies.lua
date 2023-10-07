--This is the library to render in pixelated format allows virtual resolution
--https://github.com/Ulydev/push
push = require 'lib/push'

--This is the library for class objects
-- https://github.com/vrld/hump/blob/master/class.lua
Class = require 'lib/class'

--A few global constatnts, centralized
require 'src/constants'

--Player 's Class
require 'src/Player'

--Spike 's Class
require 'src/Spike'

--Block 's Class
require 'src/Block'

--LevelMaker class for procedural generations of blocks
require 'src/LevelMaker'

--Utility functions
require 'src/Util'

--StateMachine
require 'src/StateMachine'

--States
require 'src/states/BaseState'
require 'src/states/StartState'
require 'src/states/PlayState'