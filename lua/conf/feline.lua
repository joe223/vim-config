require("feline").setup{}
--[[
   [
   [local components = require("feline.presets")["default"]
   [
   [-- https://github.dev/feline-nvim/.nvim/blob/master/lua/feline/presets/init.lua
   [components.active[1][2] = {
   [    provider = {
   [        name = 'vi_mode',
   [        opts = {
   [            show_mode_name = true
   [        }
   [    },
   [    hl = {
   [        --:help attr-list
   [        style = 'bold'
   [    }
   [}
   [components.active[1][3] = {
   [    provider = {
   [        name = "file_info",
   [        opts = {
   [            type = 'relative'
   [        },
   [    },
   [    hl = {
   [        fg = 'white',
   [        bg = 'oceanblue',
   [        style = 'bold'
   [    },
   [    left_sep = {
   [        'slant_left_2',
   [        { str = ' ', hl = { bg = 'oceanblue', fg = 'NONE' } },
   [    },
   [    right_sep = {
   [        { str = ' ', hl = { bg = 'oceanblue', fg = 'NONE' } },
   [        'slant_right_2',
   [        ' ',
   [    },
   [}
   [
   [require('feline').setup({
   [    components = components,
   [})
   ]]
