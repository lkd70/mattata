--[[
    Copyright 2017 Matthew Hesketh <wrxck0@gmail.com>
    This code is licensed under the MIT. See LICENSE for details.
]]

local qr = {}
local mattata = require('mattata')
local url = require('socket.url')

function qr:init()
    qr.commands = mattata.commands(self.info.username)
    :command('qr')
    :command('qrcode').table
    qr.help = '/qr <text> - Converts the given string of text to a QR code. Alias: /qrcode.'
end

function qr:on_message(message)
    local input = mattata.input(message.text)
    if not input
    then
        return mattata.send_reply(
            message,
            qr.help
        )
    end
    mattata.send_chat_action(
        message.chat.id,
        'upload_photo'
    )
    return mattata.send_photo(
        message.chat.id,
        'http://chart.apis.google.com/chart?cht=qr&chs=500x500&chl=' .. url.escape(input) .. '&chld=H|0.png'
    )
end

return qr