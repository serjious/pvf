PF - Pathologic Video Fix
(Pathologic Classic HD - Steam version)
For some reason, Proton does not play game videos.
The script recodes the video using the codec HEVC
It seems to work. Here are the instructions.

git clone https://github.com/serjious/pvf.git

chmod +x pvf.sh

./pvf.sh

Parameters:

-threads N (default N=4)

-nvidia (uses codec hevc_nvenc)

-amd	(uses codec hevc_amf)

-back	(returns everything to how it was)

the script can be executed from any directory

