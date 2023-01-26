#!/bin/bash

# Git - Clean very large tracked files. Use case would be for pushing and deploying to firebase, etc...

# 1. Count how many object are in the repo, for reference to see if script worked.

git count-objects -v


# 2. Run the following I noted repo root, to get the .idx index file. This has the index/DB of all files in the repo

git verify-pack -v .git/objects/pack/pack-e5fb6fdd3731cc15804e3cdf985d63ba34e6e151.idx \
| sort -k 3 -n \
| tail -10


# 3. Returns the following example:

# 6c54787149d710abf102313351772fc353a4e206 blob   2116493 1907940 209094292
# 561c1e7d7d7b0f2c982b670a22bd550f31df4632 blob   3408286 3409336 5336281
# bc35aa3de609f3e9d8db3e488a002caaaf5e4273 blob   3719362 3711578 2344105542
# 8397690b620fddc990882ade2989347e844b3829 blob   4486685 4404744 261530138
# 7a2958f68149182eae6b23b2c6a8498bbef4c3a3 blob   6405784 6389958 2254536474
# b5638cc63d2877665f2772274638f83bf554f778 blob   6425178 6413100 2311624177
# 6cbbfc4fec4ccfa7d20f2fbb4c946142a08a1406 blob   10351949 10317976 251212162
# 26524b47ee92b2f04b424dacbcc73c61db141d50 blob   33472396 26068265 2318037277
# 04813dab9d00917ba6e4d16a3719edc4c7f4207a blob   63764110 50697745 2260926432
# 30612f5843e15fa061e68baab36c8142a027c4ad blob   67902326 53522489 2201013985


# 4. Then run the following with the hash of the file at the end (from above) to see what the file/type is. This example uses the last file's hash in the list above.

git rev-list --objects --all | grep 30612f5843e15fa061e68baab36c8142a027c4ad

# Returns:

videos/Rendered AVIs from Fusion 360/MiTek - Hornet - Storyboard v14.avi


# 5. Then, run the following script runs a git-filter on all files that end with a .avi file extension. This can be replaced with the file path given above in the example for files.

git filter-branch --index-filter 'git rm --cached --ignore-unmatch *.avi' -- --all
rm -Rf .git/refs/original
rm -Rf .git/logs/
git gc --aggressive --prune=now


# 6. Run a count again to verify

git count-objects -v
