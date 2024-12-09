# Module scaffolded via skyvafnir-module-template by
# Author: Skyvafnir
moved {
  from = module.file_share_role_assignment
  to   = module.fileshare_role_assignment[0]
}

moved {
  from = module.fileshare_contributor_role_assignment
  to   = module.fileshare_contributor_role_assignment[0]
}
moved {
  from = module.file_share_role
  to   = module.fileshare_role[0]
}
