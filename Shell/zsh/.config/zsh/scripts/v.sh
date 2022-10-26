#!/usr/bin/env bash


#Get colours
# for (( i = 29; i < 38; i++ )); do echo -e "\033[0;"$i"m Normal: (0;$i); \033[1;"$i"m Light: (1;$i)"; done


GREEN='\033[0;32m'
GREY='\033[1;34m'

#We have 3 different patterns for getting versions..
# python --version
# lua -v
# go version
VERSIONS_1=(node nvm java python3 virtualenv cargo nvim) #$ --version
VERSIONS_2=(lua) #$ -v
VERSIONS_3=(go) #$ version
# Our 4th version, solc for example, prints the version on the second line
VERSIONS_4=(solc)

v() (
for v in "${VERSIONS_1[@]}"; do
printf "${GREY}Current $v version\n"
printf "${GREEN}$($v --version | sed -n '1 p')\n"
done

for v in "${VERSIONS_2[@]}"; do
printf "${GREY}Current $v version\n"
printf "${GREEN}$($v -v | sed -n '1 p')\n"
done

for v in "${VERSIONS_3[@]}"; do
printf "${GREY}Current $v version\n"
printf "${GREEN}$($v version | sed -n '1 p')\n"
done

for v in "${VERSIONS_4[@]}"; do
printf "${GREY}Current $v version\n"
printf "${GREEN}$($v --version | sed -n '2 p')\n"
done
)
