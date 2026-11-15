--- Workspaces

hl.workspace_rule({
	workspace = "1",
	monitor = "desc:Microstep MSI MAG272C 0x30303453",
	default = true,
	persistent = true,
})
hl.workspace_rule({
	workspace = "2",
	monitor = "desc:Dell Inc. DELL U2415 08DXD4AP0TAL",
})
hl.workspace_rule({ workspace = "10", monitor = "desc:AOC 24G2WG3- PIPM4JA006993", persistent = true })

-- hl.workspace_rule({
-- 	workspace = "1",
-- 	monitor = "desc:Lenovo Group Limited 0x89B2",
-- 	default = true,
-- 	persistent = true,
-- })
