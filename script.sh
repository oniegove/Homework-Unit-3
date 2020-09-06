# Create directory structure
mkdir Lucky_Duck_Investigations
cd Lucky_Duck_Investigations
mkdir Roulette_loss_Investigation
cd Roulette_loss_Investigation
mkdir Player_Analysis Dealer_Analysis Player_Dealer_Correlation
touch Player_Analysis/Notes_Player_Analysis Dealer_Analysis/Notes_Dealer_Analysis Player_Dealer_Correlation/Notes_Player_Dealer_Correlation

# Download file and get all evidence
wget "https://tinyurl.com/3-HW-setup-evidence" && chmod +x ./3-HW-setup-evidence && ./3-HW-setup-evidence

# Move player files
mv Roulette_Player_WinLoss_0310/0310* Lucky_Duck_Investigations/Roulette_loss_Investigation/Player_Analysis/
mv Roulette_Player_WinLoss_0310/0312* Lucky_Duck_Investigations/Roulette_loss_Investigation/Player_Analysis/
mv Roulette_Player_WinLoss_0310/0315* Lucky_Duck_Investigations/Roulette_loss_Investigation/Player_Analysis/
ls Lucky_Duck_Investigations/Roulette_loss_Investigation/Player_Analysis/

# Move dealer files
mv Dealer_Schedules_0310/0310* Lucky_Duck_Investigations/Roulette_loss_Investigation/Dealer_Analysis/
mv Dealer_Schedules_0310/0312* Lucky_Duck_Investigations/Roulette_loss_Investigation/Dealer_Analysis/
mv Dealer_Schedules_0310/0315* Lucky_Duck_Investigations/Roulette_loss_Investigation/Dealer_Analysis/
ls Lucky_Duck_Investigations/Roulette_loss_Investigation/Dealer_Analysis/

# Performing analysis on documents
cd Player_Analysis
head 0310_win_loss_player_data
head 0310_win_loss_player_data | grep - * > Roulette_Losses
head Roulette_Losses
#nano Notes_Player_Analysis
touch Notes_Player_Analysis
echo "0310_:05:00:00	AM" >> Notes_player_Analysis
echo "0310_:08:00:00	AM" >> Notes_player_Analysis
echo "0310_:02:00:00	PM" >> Notes_player_Analysis
echo "0310_:08:00:00	PM" >> Notes_player_Analysis
echo "0310_:11:00:00	PM" >> Notes_player_Analysis
echo "0312_:05:00:00	AM" >> Notes_player_Analysis
echo "0312_:08:00:00	AM" >> Notes_player_Analysis
echo "0312_:02:00:00	PM" >> Notes_player_Analysis
echo "0312_:08:00:00	PM" >> Notes_player_Analysis
echo "0312_:11:00:00	PM" >> Notes_player_Analysis
echo "0315_:05:00:00	AM" >> Notes_player_Analysis
echo "0315_:08:00:00	AM" >> Notes_player_Analysis
echo "0315_:02:00:00	PM" >> Notes_player_Analysis

# Finding out common actor
grep 'Mylie Schmidt' Roulette_Losses| wc -l

# Finding common dealer
cd Dealer_Analysis
head 0310_Dealer_schedule
cat 0310_Dealer_schedule | awk -F" " '{print $1, $2, $5,$6}'| grep '05:00:00 AM' > Dealers_working_during_losses
cat 0310_Dealer_schedule | awk -F" " '{print $1, $2, $5,$6}'| grep '08:00:00 AM' >> Dealers_working_during_losses
cat 0310_Dealer_schedule | awk -F" " '{print $1, $2, $5,$6}'| grep '02:00:00 PM' >> Dealers_working_during_losses
cat 0310_Dealer_schedule | awk -F" " '{print $1, $2, $5,$6}'| grep '08:00:00 PM' >> Dealers_working_during_losses
cat 0310_Dealer_schedule | awk -F" " '{print $1, $2, $5,$6}'| grep '11:00:00 PM' >> Dealers_working_during_losses
cat 0312_Dealer_schedule | awk -F" " '{print $1, $2, $5,$6}'| grep '05:00:00 AM' >> Dealers_working_during_losses
cat 0312_Dealer_schedule | awk -F" " '{print $1, $2, $5,$6}'| grep '08:00:00 AM' >> Dealers_working_during_losses
cat 0312_Dealer_schedule | awk -F" " '{print $1, $2, $5,$6}'| grep '02:00:00 PM' >> Dealers_working_during_losses
cat 0312_Dealer_schedule | awk -F" " '{print $1, $2, $5,$6}'| grep '08:00:00 PM' >> Dealers_working_during_losses
cat 0312_Dealer_schedule | awk -F" " '{print $1, $2, $5,$6}'| grep '11:00:00 PM' >> Dealers_working_during_losses
cat 0315_Dealer_schedule | awk -F" " '{print $1, $2, $5,$6}'| grep '05:00:00 AM' >> Dealers_working_during_losses
cat 0315_Dealer_schedule | awk -F" " '{print $1, $2, $5,$6}'| grep '08:00:00 AM' >> Dealers_working_during_losses
cat 0315_Dealer_schedule | awk -F" " '{print $1, $2, $5,$6}'| grep '02:00:00 PM' >> Dealers_working_during_losses
grep "Billy Jones" Dealers_working_during_losses | wc -l

# Added notes, now to create the script for the time tables.
# This script is found inside the folder of the Dealer Analysis
#nano roulette_dealer_finder_by_time.sh
echo "cat $1_Dealer_schedule | awk -F" " '{print $1, $2, $5,$6}'| grep "$2"" >> roulette_dealer_finder_by_time.sh
sh roulette_dealer_finder_by_time.sh 0310 '02:00:00 PM'

# Create bonus script
#nano roulette_dealer_finder_by_time_and_game.sh
echo "cat $1_Dealer_schedule | awk -F" " '{print $1, $2, '$3','$4' }'| grep "$2"" >> roulette_dealer_finder_by_time_and_game.sh
sh roulette_dealer_finder_by_time_and_game.sh 0310 '02:00:00 PM' '$3' '$4'
sh roulette_dealer_finder_by_time_and_game.sh 0310 '02:00:00 PM' '$5' '$6'
sh roulette_dealer_finder_by_time_and_game.sh 0310 '02:00:00 PM' '$7' '$8'
