-- CLAMSHELL MODE #
hl.bind(MainModCtrl .. " + " .. "SHIFT" .. " + " .. "E", hl.dsp.exec_cmd("clamshell open"))   -- Enable the main display
hl.bind(MainModCtrl .. " + " .. "SHIFT" .. " + " .. "D", hl.dsp.exec_cmd("clamshell closed")) -- Disable the main display
hl.bind("switch:off:Lid Switch", hl.dsp.exec_cmd("clamshell open"), { locked = true })
hl.bind("switch:on:Lid Switch", hl.dsp.exec_cmd("clamshell closed"), { locked = true })
