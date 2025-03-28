#!/bin/bash

# aegis-cli.sh - Script to automate Aegis framework setup

# Default repository URL (can be overridden with --source-repo)
REPO_URL="https://github.com/BuildSomethingAI/aegis-framework.git"
TEMP_DIR="/tmp/aegis-temp"

# Function to display the AEGIS logo
display_logo() {
  echo ""
  echo "=================================================================="
  echo ""
  echo ""
  printf "\e[49m         \e[38;5;240;48;5;235m▄\e[38;5;237;48;5;235m▄\e[49m                \e[38;5;239;48;5;234m▄\e[49m           \e[m
\e[49m         \e[38;5;8;48;5;242m▄\e[38;5;238;48;5;238m▄\e[49m  \e[38;5;235;49m▄\e[38;5;238;49m▄\e[38;5;60;49m▄\e[38;5;246;48;5;233m▄\e[38;5;247;48;5;234m▄\e[38;5;246;48;5;236m▄▄\e[38;5;8;48;5;234m▄\e[38;5;60;49m▄\e[38;5;238;49m▄\e[38;5;236;49m▄\e[38;5;234;49m▄\e[49m \e[38;5;239;49m▄\e[38;5;59;48;5;59m▄\e[49m           \e[m
\e[49m         \e[38;5;236;48;5;8m▄\e[38;5;237;48;5;237m▄\e[38;5;60;48;5;238m▄\e[38;5;254;48;5;8m▄\e[38;5;255;48;5;250m▄\e[38;5;60;48;5;254m▄\e[38;5;235;48;5;103m▄\e[38;5;235;48;5;236m▄\e[48;5;235m   \e[38;5;235;48;5;235m▄▄▄\e[38;5;235;48;5;236m▄\e[38;5;235;48;5;235m▄\e[38;5;235;48;5;234m▄\e[38;5;234;48;5;234m▄\e[38;5;234;48;5;238m▄\e[38;5;235;49m▄\e[49m          \e[m
\e[49m       \e[38;5;234;49m▄\e[38;5;235;48;5;235m▄\e[38;5;7;48;5;59m▄\e[38;5;15;48;5;255m▄\e[38;5;252;48;5;145m▄\e[38;5;248;48;5;252m▄\e[38;5;253;48;5;253m▄\e[38;5;236;48;5;236m▄\e[48;5;235m         \e[38;5;235;48;5;235m▄▄▄▄\e[38;5;234;48;5;234m▄▄\e[49m         \e[m
\e[49m       \e[38;5;59;48;5;235m▄\e[38;5;60;48;5;235m▄\e[38;5;60;48;5;252m▄\e[38;5;253;48;5;15m▄\e[38;5;255;48;5;254m▄\e[38;5;60;48;5;60m▄\e[38;5;239;48;5;253m▄\e[38;5;243;48;5;60m▄\e[38;5;246;48;5;236m▄\e[38;5;8;48;5;235m▄\e[38;5;239;48;5;235m▄\e[38;5;236;48;5;235m▄\e[48;5;235m   \e[38;5;235;48;5;235m▄▄\e[38;5;235;48;5;234m▄\e[38;5;235;48;5;235m▄▄\e[38;5;234;48;5;235m▄\e[38;5;236;48;5;234m▄\e[38;5;235;48;5;234m▄\e[38;5;234;49m▄\e[49m        \e[m
\e[49m      \e[38;5;235;49m▄\e[38;5;239;48;5;238m▄\e[38;5;243;48;5;237m▄\e[38;5;188;48;5;60m▄\e[38;5;7;48;5;239m▄\e[38;5;8;48;5;239m▄\e[38;5;236;48;5;60m▄\e[38;5;235;48;5;239m▄\e[38;5;238;48;5;237m▄▄\e[38;5;235;48;5;236m▄\e[38;5;234;48;5;235m▄▄▄▄\e[38;5;236;48;5;235m▄\e[38;5;23;48;5;234m▄\e[38;5;235;48;5;235m▄\e[38;5;235;48;5;236m▄\e[38;5;23;48;5;235m▄▄\e[38;5;235;48;5;236m▄\e[38;5;23;48;5;236m▄\e[38;5;235;48;5;235m▄\e[38;5;235;48;5;234m▄\e[38;5;234;49m▄\e[49m       \e[m
\e[49m     \e[38;5;246;48;5;240m▄\e[38;5;167;48;5;188m▄\e[38;5;240;48;5;242m▄▄\e[38;5;236;48;5;249m▄\e[38;5;234;48;5;60m▄▄\e[38;5;234;48;5;247m▄\e[38;5;234;48;5;248m▄\e[38;5;234;48;5;239m▄\e[38;5;236;48;5;236m▄\e[38;5;238;48;5;238m▄\e[38;5;239;48;5;239m▄▄▄\e[38;5;238;48;5;238m▄\e[38;5;236;48;5;235m▄\e[38;5;234;48;5;236m▄\e[38;5;234;48;5;24m▄\e[38;5;234;48;5;236m▄\e[38;5;234;48;5;234m▄\e[48;5;234m  \e[38;5;236;48;5;236m▄\e[48;5;235m \e[38;5;53;48;5;89m▄\e[38;5;89;48;5;53m▄\e[38;5;235;48;5;234m▄\e[49m      \e[m
\e[49m     \e[38;5;245;48;5;245m▄\e[38;5;131;48;5;167m▄\e[38;5;241;48;5;59m▄\e[38;5;235;48;5;238m▄\e[38;5;238;48;5;237m▄\e[38;5;6;48;5;6m▄\e[38;5;73;48;5;24m▄\e[38;5;73;48;5;237m▄\e[38;5;31;48;5;235m▄\e[38;5;23;48;5;234m▄\e[38;5;234;48;5;234m▄▄\e[48;5;234m    \e[38;5;234;48;5;234m▄\e[38;5;237;48;5;234m▄\e[38;5;30;48;5;234m▄\e[38;5;73;48;5;237m▄\e[38;5;37;48;5;23m▄\e[38;5;24;48;5;24m▄\e[38;5;23;48;5;23m▄\e[38;5;236;48;5;236m▄\e[38;5;236;48;5;235m▄\e[38;5;125;48;5;89m▄\e[38;5;125;48;5;125m▄\e[38;5;235;48;5;235m▄\e[49m      \e[m
\e[49m     \e[38;5;235;48;5;243m▄\e[38;5;238;48;5;131m▄\e[38;5;238;48;5;240m▄\e[38;5;59;48;5;237m▄\e[38;5;237;48;5;237m▄\e[38;5;23;48;5;24m▄\e[38;5;30;48;5;73m▄\e[38;5;6;48;5;73m▄\e[38;5;73;48;5;73m▄▄\e[38;5;73;48;5;30m▄\e[38;5;237;48;5;234m▄\e[48;5;234m   \e[38;5;234;48;5;234m▄\e[38;5;31;48;5;23m▄\e[38;5;73;48;5;73m▄\e[48;5;73m \e[38;5;73;48;5;73m▄\e[38;5;24;48;5;31m▄\e[38;5;24;48;5;24m▄\e[38;5;235;48;5;236m▄▄\e[38;5;236;48;5;236m▄\e[38;5;53;48;5;125m▄\e[38;5;238;48;5;89m▄\e[49;38;5;237m▀\e[49m      \e[m
\e[49m      \e[49;38;5;234m▀\e[38;5;234;48;5;236m▄\e[38;5;237;48;5;240m▄\e[38;5;238;48;5;236m▄\e[38;5;237;48;5;237m▄\e[38;5;236;48;5;31m▄\e[38;5;24;48;5;67m▄\e[38;5;25;48;5;30m▄\e[38;5;31;48;5;30m▄\e[38;5;30;48;5;37m▄\e[38;5;237;48;5;23m▄\e[48;5;234m   \e[38;5;235;48;5;235m▄\e[38;5;24;48;5;31m▄\e[38;5;31;48;5;31m▄\e[38;5;31;48;5;6m▄\e[38;5;24;48;5;31m▄\e[38;5;23;48;5;73m▄\e[38;5;235;48;5;24m▄\e[38;5;235;48;5;235m▄\e[38;5;23;48;5;235m▄\e[38;5;235;48;5;236m▄\e[49;38;5;236m▀\e[49;38;5;234m▀\e[49m       \e[m
\e[49m        \e[49;38;5;234m▀\e[38;5;236;48;5;236m▄\e[38;5;236;48;5;237m▄\e[38;5;234;48;5;238m▄\e[38;5;235;48;5;235m▄\e[38;5;236;48;5;235m▄\e[38;5;238;48;5;23m▄\e[38;5;237;48;5;24m▄\e[38;5;234;48;5;235m▄\e[38;5;234;48;5;234m▄▄▄▄\e[38;5;235;48;5;24m▄\e[38;5;236;48;5;24m▄\e[38;5;235;48;5;236m▄\e[38;5;234;48;5;234m▄\e[38;5;234;48;5;235m▄\e[38;5;235;48;5;235m▄\e[38;5;23;48;5;235m▄\e[38;5;235;48;5;23m▄\e[49;38;5;233m▀\e[49m         \e[m
\e[49m          \e[49;38;5;236m▀\e[38;5;236;48;5;23m▄\e[38;5;236;48;5;235m▄\e[38;5;23;48;5;234m▄\e[38;5;236;48;5;234m▄\e[38;5;234;48;5;235m▄\e[38;5;234;48;5;237m▄\e[38;5;234;48;5;238m▄▄▄\e[38;5;234;48;5;237m▄\e[38;5;234;48;5;236m▄\e[38;5;235;48;5;234m▄\e[38;5;23;48;5;234m▄▄\e[38;5;236;48;5;235m▄\e[38;5;235;48;5;23m▄\e[49;38;5;236m▀\e[49m           \e[m
\e[49m         \e[38;5;234;49m▄▄\e[38;5;235;49m▄\e[38;5;245;48;5;234m▄\e[38;5;235;48;5;234m▄\e[38;5;234;48;5;236m▄\e[38;5;235;48;5;23m▄▄\e[38;5;234;48;5;236m▄\e[38;5;234;48;5;235m▄▄\e[38;5;234;48;5;236m▄\e[38;5;234;48;5;23m▄▄\e[38;5;234;48;5;235m▄\e[38;5;237;48;5;234m▄\e[38;5;237;49m▄\e[38;5;236;49m▄▄\e[38;5;235;49m▄\e[49m          \e[m
\e[49m       \e[38;5;8;48;5;237m▄\e[38;5;188;48;5;242m▄\e[38;5;235;48;5;243m▄\e[38;5;234;48;5;238m▄\e[38;5;236;48;5;237m▄\e[38;5;239;48;5;7m▄\e[38;5;60;48;5;240m▄\e[38;5;237;48;5;235m▄\e[38;5;235;48;5;234m▄\e[38;5;234;48;5;235m▄\e[38;5;234;48;5;236m▄\e[38;5;234;48;5;235m▄▄▄\e[48;5;234m \e[38;5;235;48;5;234m▄\e[38;5;237;48;5;234m▄\e[38;5;238;48;5;24m▄\e[38;5;237;48;5;238m▄\e[38;5;234;48;5;235m▄\e[38;5;234;48;5;234m▄\e[38;5;234;48;5;235m▄\e[38;5;24;48;5;236m▄\e[38;5;235;49m▄\e[49m        \e[m
\e[49m     \e[38;5;235;49m▄\e[38;5;242;48;5;234m▄\e[38;5;243;48;5;248m▄\e[38;5;237;48;5;251m▄\e[38;5;236;48;5;237m▄\e[38;5;234;48;5;234m▄\e[38;5;236;48;5;236m▄\e[38;5;239;48;5;239m▄\e[38;5;238;48;5;238m▄\e[38;5;237;48;5;239m▄\e[38;5;238;48;5;66m▄\e[38;5;238;48;5;60m▄\e[38;5;238;48;5;239m▄▄\e[38;5;238;48;5;238m▄\e[38;5;60;48;5;239m▄\e[38;5;60;48;5;60m▄\e[38;5;24;48;5;239m▄\e[38;5;24;48;5;24m▄\e[38;5;235;48;5;238m▄\e[38;5;234;48;5;236m▄\e[48;5;234m \e[38;5;234;48;5;234m▄▄\e[38;5;237;48;5;24m▄\e[38;5;240;48;5;23m▄\e[38;5;235;48;5;235m▄\e[38;5;234;49m▄\e[49m      \e[m
\e[49m     \e[38;5;8;48;5;8m▄\e[38;5;235;48;5;243m▄\e[38;5;234;48;5;234m▄\e[38;5;234;48;5;235m▄\e[38;5;234;48;5;234m▄\e[38;5;235;48;5;234m▄\e[38;5;234;48;5;234m▄\e[38;5;234;48;5;235m▄\e[38;5;234;48;5;234m▄\e[38;5;234;48;5;235m▄\e[38;5;234;48;5;237m▄\e[38;5;235;48;5;238m▄\e[38;5;236;48;5;238m▄\e[38;5;237;48;5;238m▄▄\e[38;5;6;48;5;67m▄\e[38;5;73;48;5;73m▄▄\e[38;5;30;48;5;30m▄\e[48;5;234m \e[38;5;237;48;5;234m▄\e[38;5;252;48;5;238m▄\e[38;5;145;48;5;8m▄\e[38;5;245;48;5;245m▄\e[38;5;243;48;5;239m▄\e[38;5;234;48;5;234m▄▄\e[38;5;235;48;5;234m▄\e[49m      \e[m
\e[49m     \e[38;5;243;48;5;246m▄\e[38;5;249;48;5;236m▄\e[38;5;235;48;5;234m▄\e[38;5;236;48;5;235m▄\e[38;5;239;48;5;237m▄\e[38;5;236;48;5;234m▄\e[38;5;238;48;5;235m▄\e[38;5;236;48;5;234m▄\e[38;5;246;48;5;234m▄▄\e[38;5;66;48;5;234m▄\e[38;5;234;48;5;234m▄\e[48;5;234m \e[38;5;234;48;5;234m▄▄▄▄▄▄\e[38;5;60;48;5;234m▄\e[38;5;238;48;5;238m▄\e[38;5;235;48;5;243m▄\e[38;5;237;48;5;239m▄\e[38;5;237;48;5;242m▄\e[38;5;236;48;5;239m▄\e[38;5;237;48;5;238m▄\e[38;5;23;48;5;235m▄\e[38;5;235;48;5;236m▄\e[49m      \e[m
\e[38;5;234;49m▄\e[38;5;246;49m▄\e[38;5;252;48;5;235m▄\e[38;5;249;48;5;236m▄\e[38;5;7;48;5;235m▄\e[38;5;246;48;5;234m▄\e[38;5;235;48;5;248m▄\e[38;5;245;48;5;102m▄\e[38;5;236;48;5;238m▄\e[38;5;239;48;5;239m▄\e[38;5;239;48;5;243m▄\e[38;5;234;48;5;238m▄\e[38;5;239;48;5;242m▄\e[38;5;235;48;5;237m▄\e[38;5;235;48;5;234m▄\e[38;5;234;48;5;235m▄\e[38;5;234;48;5;238m▄\e[38;5;238;48;5;234m▄\e[48;5;234m \e[38;5;242;48;5;234m▄\e[38;5;137;48;5;235m▄▄\e[38;5;95;48;5;234m▄\e[38;5;235;48;5;245m▄\e[38;5;235;48;5;236m▄\e[38;5;234;48;5;234m▄\e[38;5;235;48;5;234m▄▄\e[38;5;235;48;5;236m▄\e[38;5;235;48;5;235m▄\e[38;5;234;48;5;236m▄\e[38;5;235;48;5;23m▄\e[38;5;247;48;5;235m▄\e[38;5;145;48;5;235m▄\e[38;5;237;48;5;236m▄\e[38;5;235;48;5;237m▄\e[38;5;23;48;5;235m▄\e[38;5;23;49m▄\e[38;5;235;49m▄\e[m
\e[38;5;242;48;5;59m▄\e[38;5;237;48;5;247m▄\e[38;5;234;48;5;234m▄\e[48;5;234m  \e[38;5;234;48;5;236m▄\e[38;5;234;48;5;246m▄\e[38;5;236;48;5;236m▄\e[38;5;235;48;5;234m▄\e[38;5;234;48;5;234m▄▄\e[38;5;234;48;5;235m▄\e[38;5;235;48;5;236m▄\e[38;5;235;48;5;235m▄\e[48;5;235m \e[38;5;235;48;5;235m▄▄\e[38;5;234;48;5;237m▄\e[48;5;234m \e[38;5;236;48;5;242m▄\e[38;5;238;48;5;178m▄\e[38;5;59;48;5;179m▄\e[38;5;179;48;5;137m▄\e[38;5;215;48;5;239m▄\e[38;5;215;48;5;240m▄\e[38;5;95;48;5;237m▄\e[48;5;235m  \e[38;5;235;48;5;235m▄\e[38;5;243;48;5;235m▄\e[38;5;7;48;5;240m▄\e[38;5;237;48;5;7m▄\e[38;5;234;48;5;60m▄\e[48;5;234m  \e[38;5;234;48;5;234m▄▄\e[38;5;235;48;5;236m▄\e[38;5;23;48;5;23m▄\e[m
\e[38;5;239;48;5;243m▄\e[38;5;237;48;5;236m▄\e[48;5;234m     \e[38;5;234;48;5;234m▄▄▄▄▄▄\e[38;5;234;48;5;235m▄▄\e[38;5;8;48;5;236m▄\e[38;5;180;48;5;237m▄\e[38;5;143;48;5;234m▄\e[38;5;179;48;5;236m▄\e[38;5;143;48;5;234m▄\e[38;5;137;48;5;236m▄\e[38;5;239;48;5;237m▄\e[38;5;137;48;5;215m▄\e[38;5;101;48;5;214m▄▄\e[38;5;239;48;5;59m▄\e[38;5;238;48;5;235m▄\e[38;5;239;48;5;236m▄\e[38;5;239;48;5;239m▄\e[38;5;238;48;5;102m▄\e[38;5;234;48;5;234m▄\e[48;5;234m      \e[38;5;235;48;5;234m▄\e[38;5;235;48;5;23m▄\e[m
\e[49;38;5;239m▀\e[38;5;238;48;5;239m▄\e[38;5;237;48;5;234m▄\e[38;5;234;48;5;234m▄\e[48;5;234m      \e[38;5;234;48;5;234m▄▄\e[38;5;235;48;5;234m▄\e[38;5;234;48;5;234m▄▄\e[38;5;138;48;5;138m▄\e[38;5;214;48;5;215m▄\e[38;5;178;48;5;214m▄\e[38;5;179;48;5;178m▄\e[38;5;143;48;5;178m▄\e[38;5;143;48;5;179m▄\e[38;5;73;48;5;115m▄\e[38;5;73;48;5;73m▄▄▄\e[38;5;60;48;5;24m▄\e[38;5;235;48;5;237m▄\e[38;5;237;48;5;238m▄\e[38;5;235;48;5;238m▄\e[38;5;234;48;5;235m▄\e[48;5;234m     \e[38;5;234;48;5;234m▄\e[38;5;235;48;5;234m▄\e[38;5;235;48;5;235m▄\e[49;38;5;236m▀\e[m
\e[49m  \e[49;38;5;235m▀\e[38;5;234;48;5;234m▄▄▄\e[48;5;234m    \e[38;5;235;48;5;234m▄\e[38;5;236;48;5;235m▄\e[38;5;73;48;5;239m▄▄\e[38;5;73;48;5;23m▄\e[38;5;66;48;5;241m▄\e[38;5;73;48;5;101m▄\e[38;5;73;48;5;65m▄\e[38;5;67;48;5;242m▄\e[38;5;131;48;5;95m▄\e[38;5;125;48;5;95m▄\e[38;5;125;48;5;59m▄\e[38;5;125;48;5;60m▄\e[38;5;125;48;5;240m▄▄\e[38;5;238;48;5;236m▄\e[38;5;235;48;5;235m▄▄\e[38;5;234;48;5;234m▄▄\e[48;5;234m    \e[38;5;235;48;5;234m▄\e[38;5;235;48;5;235m▄\e[38;5;233;48;5;235m▄\e[49m  \e[m
\e[49m    \e[38;5;235;48;5;235m▄\e[38;5;234;48;5;234m▄▄▄▄\e[38;5;234;48;5;235m▄\e[38;5;234;48;5;234m▄\e[38;5;236;48;5;235m▄\e[38;5;144;48;5;66m▄\e[38;5;179;48;5;73m▄\e[38;5;143;48;5;73m▄\e[38;5;59;48;5;24m▄\e[38;5;143;48;5;73m▄▄\e[38;5;101;48;5;66m▄\e[38;5;132;48;5;131m▄\e[38;5;131;48;5;125m▄\e[38;5;125;48;5;125m▄\e[38;5;53;48;5;125m▄\e[38;5;236;48;5;125m▄▄\e[38;5;8;48;5;239m▄\e[38;5;73;48;5;235m▄\e[38;5;67;48;5;235m▄\e[38;5;6;48;5;234m▄\e[38;5;235;48;5;235m▄\e[38;5;235;48;5;234m▄▄\e[38;5;234;48;5;234m▄▄▄\e[38;5;235;49m▄\e[49m   \e[m
\e[49m       \e[49;38;5;235m▀\e[49;38;5;234m▀▀▀\e[38;5;240;48;5;236m▄\e[38;5;137;48;5;179m▄\e[38;5;173;48;5;214m▄\e[38;5;137;48;5;178m▄\e[38;5;239;48;5;59m▄\e[38;5;137;48;5;178m▄\e[38;5;178;48;5;214m▄\e[38;5;95;48;5;137m▄\e[38;5;131;48;5;167m▄\e[38;5;125;48;5;161m▄▄\e[38;5;89;48;5;53m▄\e[49;38;5;234m▀\e[38;5;234;48;5;234m▄\e[38;5;23;48;5;66m▄\e[38;5;6;48;5;73m▄▄\e[38;5;23;48;5;30m▄\e[38;5;234;48;5;234m▄\e[49;38;5;235m▀\e[49;38;5;234m▀▀\e[49;38;5;235m▀\e[49m     \e[m
"
  echo "                                      "
  echo "                                      "
  echo "    █████╗ ███████╗ ██████╗ ██╗███████╗"
  echo "   ██╔══██╗██╔════╝██╔════╝ ██║██╔════╝"
  echo "   ███████║█████╗  ██║  ███╗██║███████╗"
  echo "   ██╔══██║██╔══╝  ██║   ██║██║╚════██║"
  echo "   ██║  ██║███████╗╚██████╔╝██║███████║"
  echo "   ╚═╝  ╚═╝╚══════╝ ╚═════╝ ╚═╝╚══════╝"
  echo "                                      "
  echo ""
  echo "=================================================================="
  echo ""

}

# Function to display usage information
show_usage() {
  display_logo
  echo "Usage: aegis-cli.sh <command> [options]"
  echo ""
  echo "Commands:"
  echo "  init [path]    Initialize a project with Aegis framework"
  echo "                 - Without path: Initialize in current directory"
  echo "                 - With path: Initialize in specified directory"
  echo ""
  echo "Options:"
  echo "  --clone                  Clone the repository first (for latest version)"
  echo "  --local                  Use local copy (requires --source-repo)"
  echo "  --source-repo <path>     Specify local repository path"
  echo ""
  echo "Examples:"
  echo "  aegis-cli.sh init                                         # Clone into current directory"
  echo "  aegis-cli.sh init ~/myproject                             # Clone into ~/myproject"
  echo "  aegis-cli.sh init --local --source-repo ~/path/to/aegis   # Use local copy"
}

# Function to get the latest version via clone
get_latest_version() {
  echo "Getting latest version of Aegis framework..."
  
  # Create and clean temp directory
  rm -rf "$TEMP_DIR" 2>/dev/null
  mkdir -p "$TEMP_DIR"
  
  # Clone repository to temp directory
  git clone "$REPO_URL" "$TEMP_DIR" || { 
    echo "Git clone failed. Trying to download zip instead..."
    
    # Try downloading zip as fallback (assuming there's a zip download available)
    # Replace ZIP_URL with actual download URL
    ZIP_URL="https://github.com/BuildSomethingAI/aegis-framework/archive/refs/heads/main.zip"
    curl -L "$ZIP_URL" -o "$TEMP_DIR/aegis-framework.zip"
    
    if [ $? -ne 0 ]; then
      echo "Failed to download framework. Check your internet connection."
      exit 1
    fi
    
    # Extract zip
    unzip "$TEMP_DIR/aegis-framework.zip" -d "$TEMP_DIR"
    # Find extracted directory (may vary based on zip structure)
    EXTRACT_DIR=$(find "$TEMP_DIR" -type d -name "aegis-framework*" | head -n 1)
    # Move contents up to temp dir
    mv "$EXTRACT_DIR"/* "$TEMP_DIR"
  }
  echo ""
  echo " ☑️  Latest version obtained."
}

# Function to use local version
use_local_version() {
  local source_repo="$1"
  
  echo "Using local version of Aegis framework..."
  
  # Check if source repository exists
  if [ ! -d "$source_repo" ]; then
    echo "Error: Local source repository not found at $source_repo"
    echo "Please provide a valid path with --source-repo or use --clone option instead."
    exit 1
  fi
  
  # Create and clean temp directory
  rm -rf "$TEMP_DIR" 2>/dev/null
  mkdir -p "$TEMP_DIR"
  
  # Copy local repo to temp directory
  cp -R "$source_repo"/* "$TEMP_DIR"
  cp -R "$source_repo"/.[!.]* "$TEMP_DIR" 2>/dev/null || true  # Also copy hidden files
  
  echo "Local version prepared."
}

# Function to setup project
setup_project() {
  local dest_path="${1:-.}"  # If no path provided, use current directory
  
  # Check if destination exists
  if [ ! -d "$dest_path" ]; then
    echo "Creating destination directory: $dest_path"
    mkdir -p "$dest_path" || { echo "Failed to create destination directory"; exit 1; }
  fi
  
  # Convert to absolute path
  dest_path=$(cd "$dest_path" 2>/dev/null && pwd)
  
  display_logo
  echo "Setting up Aegis framework in: $dest_path"
  echo ""
  
  # Copy .context directory
  if [ -d "$TEMP_DIR/.context" ]; then
    echo " ☑️  Copying .context directory to project root..."
    cp -R "$TEMP_DIR/.context" "$dest_path/"
  else
    echo " ⚠️ Error: .context directory not found in the framework."
    exit 1
  fi
  
  # Check for commands files (case insensitive)
  COMMANDS_JSON=""
  COMMANDS_MD=""
  
  # Look for commands.json or Commands.json
  if [ -f "$TEMP_DIR/commands.json" ]; then
    COMMANDS_JSON="$TEMP_DIR/commands.json"
  elif [ -f "$TEMP_DIR/Commands.json" ]; then
    COMMANDS_JSON="$TEMP_DIR/Commands.json"
  fi
  
  # Look for commands.md or Commands.md
  if [ -f "$TEMP_DIR/commands.md" ]; then
    COMMANDS_MD="$TEMP_DIR/commands.md"
  elif [ -f "$TEMP_DIR/Commands.md" ]; then
    COMMANDS_MD="$TEMP_DIR/Commands.md"
  fi
  
  # Copy commands files if found
  if [ -n "$COMMANDS_JSON" ]; then
    echo " ☑️  Copying commands.json for manual integration..."
    cp "$COMMANDS_JSON" "$dest_path/aegis-commands.json"
  fi
  
  if [ -n "$COMMANDS_MD" ]; then
    echo " ☑️  Copying commands.md for reference..."
    cp "$COMMANDS_MD" "$dest_path/aegis-commands.md"
  fi
  
  # Display instructions if commands files were found
if [ -n "$COMMANDS_JSON" ] || [ -n "$COMMANDS_MD" ]; then
  echo ""
  echo " 👉🏼 NEXT STEP (Manual): Copy contents from ONE of the following files"
  echo " to your Cursor rules panel (you may delete both after you are finished):"
  echo ""

  
  if [ -n "$COMMANDS_JSON" ]; then
    echo " - $dest_path/aegis-commands.json (for JSON)"
  fi
  
  if [ -n "$COMMANDS_MD" ]; then
    echo " - $dest_path/aegis-commands.md (for Markdown)"
  fi

else
  echo " ⚠️ No commands files (commands.json/md) found in the framework."
fi

# Add documentation links
echo ""
echo " ℹ️  Documentation:"
echo ""
echo " - Quick Start Guide: https://buildsomething.ai/aegis/quick-start/"
echo " - GitHub Repository: https://github.com/BuildSomethingAI/aegis-framework"
echo " - Cursor AI Rules: https://cursor.sh/docs/ai-rules"

echo ""
echo " ✅ Aegis framework setup complete!"
echo ""
echo "=================================================================="
echo ""
}

# Main command handling
if [ $# -eq 0 ]; then
  show_usage
  exit 0
fi

command="$1"
shift  # Remove the command from arguments list

# Default method is clone
method="clone"
dest_path=""
source_repo=""

# Parse options
while [[ $# -gt 0 ]]; do
  case "$1" in
    --clone)
      method="clone"
      shift
      ;;
    --local)
      method="local"
      shift
      ;;
    --source-repo)
      source_repo="$2"
      shift 2
      ;;
    *)
      dest_path="$1"
      shift
      ;;
  esac
done

case "$command" in
  "init")
    # Get framework based on chosen method
    if [ "$method" = "clone" ]; then
      get_latest_version
    elif [ "$method" = "local" ]; then
      if [ -z "$source_repo" ]; then
        echo "Error: --local option requires --source-repo to be specified."
        show_usage
        exit 1
      fi
      use_local_version "$source_repo"
    fi
    
    # Setup project
    setup_project "$dest_path"
    
    # Clean up temp directory
    rm -rf "$TEMP_DIR"
    ;;
  *)
    echo "Unknown command: $command"
    show_usage
    exit 1
    ;;
esac