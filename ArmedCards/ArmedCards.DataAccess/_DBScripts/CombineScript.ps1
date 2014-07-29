.\CombineFiles.ps1 -output "Master.sql" -source "ActiveConnection\" -filter "*.sql"
.\CombineFiles.ps1 -output "Master.sql" -source "User\" -filter "*.sql" -append
.\CombineFiles.ps1 -output "Master.sql" -source "Card\" -filter "*.sql" -append
.\CombineFiles.ps1 -output "Master.sql" -source "Deck\" -filter "*.sql" -append
.\CombineFiles.ps1 -output "Master.sql" -source "DeckCard\" -filter "*.sql" -append
.\CombineFiles.ps1 -output "Master.sql" -source "Game\" -filter "*.sql" -append
.\CombineFiles.ps1 -output "Master.sql" -source "GameDeck\" -filter "*.sql" -append
.\CombineFiles.ps1 -output "Master.sql" -source "GamePlayer\" -filter "*.sql" -append
.\CombineFiles.ps1 -output "Master.sql" -source "GamePlayerCard\" -filter "*.sql" -append
.\CombineFiles.ps1 -output "Master.sql" -source "GameRound\" -filter "*.sql" -append
.\CombineFiles.ps1 -output "Master.sql" -source "GameRoundCard\" -filter "*.sql" -append
.\CombineFiles.ps1 -output "Master.sql" -source "GamePlayerKickVote\" -filter "*.sql" -append
.\CombineFiles.ps1 -output "Master.sql" -source "Leaderboards\" -filter "*.sql" -append
.\CombineFiles.ps1 -output "Master.sql" -source "ChatMessage\" -filter "*.sql" -append