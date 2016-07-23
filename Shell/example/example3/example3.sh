#!/bin/bash
#
# Description of this script
# $1       -- instruction: help or exec
# $2 & $4  -- navigator arg
# $3       -- input file
# $5       -- output directory
#
# Description output file exported by MySQL
# $1       -- activation
# $2       -- username
# $3       -- id_student
# $4       -- grade
# $[5-9]   -- subname and mainname


case "$1" in
	# HELP
	"-h" | "--help")	
		echo " INSTRUCTION: "
		echo " -h  --help          Show this instruction"
		echo " -x  --exec          Run"
		echo "     --input-file    Input text file"
		echo "     --output-dir    Output directory (option: default as default)"
		echo
		echo " Example: "
		echo " ./example3.sh -x --input-file <Input file path> --output-dir <Output directory path>"
		echo " ./example3.sh --exec --input-file <Input file path> --output-dir default"
		echo
		;;
	
	# EXECUTIVE
	"-x" | "--exec")
		# catch number of line in file and loop - lay so dong trong file text va thuc hien lap
		numline=$(cat $3 | wc -l)
		# catch maximum of id - lay gia tri id lon nhat
		#max_id=$(tail -n 1 $3 | awk '{print $1}')
		# browse begin 2nd line - bat dau duyet tu dong thu hai
		i=2
		while [ $i -le $numline ] ;
		do
			# activated or not
			activated=$(cat $3 | awk -v line=$i 'NR==line' | awk '{print $1}' | sed 's/"//g')
			# lay username
			username=$(cat $3 | awk -v line=$i 'NR==line' | awk '{print $2}' | sed 's/"//g')
			# lay id_student
			id_student=$(cat $3 |awk -v line=$i 'NR==line' | awk '{print $3}' | sed 's/"//g') 
			# lay grade
			grade=$(cat $3 | awk -v line=$i 'NR==line' | awk '{print $4}' | sed 's/"//g')

			# paraphrase
			#
			# with awk: an interpreted programming language designed for text processing
			#           the leftmost longest rule:  http://www.boost.org/doc/libs/1_56_0/libs/regex/doc/html/boost_regex/syntax/leftmost_longest_rule.html
			#           attach a variable:          awk -v <name of variable of awk command>=$<another variable in the shell> '{script}'
			#                                       awk -v <name of variable of awk command>=<value> '{script}'
			#           print field contain:        awk '{ print $<numerical order of field>}'
			#                                       numerical order of field start from 1 to NF
			#           sub(regexp, replacement [, target]): see http://www.delorie.com/gnu/docs/gawk/gawk_135.html
			#           gsub(regexp, replacement [, target]): see http://www.delorie.com/gnu/docs/gawk/gawk_135.html
			#           replace print with printf to printing without newline
			#           'NR' as Number of Records Variable
			#           'NF' as Number of Fields in a record
			#
			# with tr:  translate or delete characters
			#           replace SET1 by SET2:      tr SET1 SET2
			#           delete a pattern:          tr -d '<pattern>'
			#           '\r' as Carriage Return
			#           '\n' as Line Feed
			#
			# with sed: stream editor for filtering and transforming text
			#           sed 's/"//g'               same as tr -d '"'
			#           sed ':a;N;$!ba;s/\n//g'    same as tr -d '\n'
			#

			# name dir is followed real name
			#folder=$(cat $3 | awk -v line=$i 'NR==line' | awk -v line=$i '{ if ($9!="") print $5"_"$6"_"$7"_"$8"_"$9 ; else if ($8!="") print $5"_"$6"_"$7"_"$8 ; else if ($7!="") print $5"_"$6"_"$7 ; else print $5"_"$6 ; }' | sed 's/"//g')
			#folder=$(cat $3 | awk -v line=$i 'NR==line' | awk -v line=$i '{ if ($9!="") print $5$6$7$8$9 ; else if ($8!="") print $5$6$7$8 ; else if ($7!="") print $5$6$7 ; else print $5$6 ; }' | sed 's/"//g')
			#folder=$(cat $3 | awk -v line=$i 'NR==line' | awk '{print $5$6$7$8$9 ; }' | sed 's/"//g')
			#folder=$(cat $3 | awk -v line=$i 'NR==line' | awk '{ for(field=5;field<=NF;field++) print $field; }' | sed 's/"//g' | sed ':a;N;$!ba;s/\n//g')
			folder=$(cat $3 | awk -v line=$i 'NR==line' | awk '{ for(field=5;field<=NF;field++) { printf $field ; } }' | awk '{ gsub("\"",""); print ; }')
			#folder=$(cat $3 | awk -v line=$i 'NR==line' | awk '{ for(field=5;field<=NF;field++) { printf $field ; } }' | tr -d '"' | tr -d '\r\n')
			realname=$folder
			# Root or not
			if [ $username != "Root" ];
			then
				# is activated
				if [ $activated == '1' ];
				then
					# output preset default
					if [ $5 == "default" ];
					then
						# write the following contents to file - ghi noi dung vao file
						echo "chroot_local_user=YES" > /etc/vsftpd_user_conf/$username
						echo "local_root=/home/vsftpd/Root/Archives/K$grade/$folder" >> /etc/vsftpd_user_conf/$username
						echo "user_sub_token=$username" >> /etc/vsftpd_user_conf/$username
						# make new directory named realname of user with grade (continuous, nospace)
						# khoi tao thu muc moi mang ho ten cua thanh vien viet lien khong khoang trang
						mkdir /home/vsftpd/Root/Archives/K$grade/$realname
						# make a symbolic link named realname of user with grade (continuous, nospace) pointed a file named realname of user
						# khoi tao mot symbolic link mang ho ten cua thanh vien tro toi file mang ten cua username
						ln -s /etc/vsftpd_user_conf/$username /etc/vsftpd_user_conf/$folder
						# change owner - dat lai quyen so huu
						chown vsftpd:nogroup -R /home/vsftpd/Root/Archives/*
						# change mode bits - dat lai quyen truy cap
						chmod 757 -R /home/vsftpd/Root/Archives/*
						# make a symbolic link placed in user's directory pointed Book directory of Root
						# khoi tao mot symbolic link nam trong thu muc cua thanh vien tro toi thu muc Book cua Root
						ln -s /home/vsftpd/Root/Book /home/vsftpd/Root/Archives/K$grade/$realname/Book
					else
						# write the following contents to file - ghi noi dung vao file
						echo "chroot_local_user=YES" > $5$username
						echo "local_root=/home/vsftpd/Root/Archives/K$grade/$folder" >> $5$username
						echo "user_sub_token=$username" >> $5$username
						# make new directory named realname of user with grade (continuous, nospace)
						# khoi tao thu muc moi mang ho ten cua thanh vien viet lien khong khoang trang
						mkdir $5K$grade/$folder
						# make a symbolic link named realname of user with grade (continuous, nospace) pointed a file named realname of user
						# khoi tao mot symbolic link mang ho ten cua thanh vien tro toi file mang ten cua username
						ln -s $5$username $5$folder
					fi
				fi
			fi	
			#i=$(( i++ ))
			i=`expr $i + 1`
		done
		echo "write done"
		;;

	# DELETE
	#"-D" | "--delete")
		# kiem tra doi so truyen vao
		#if [ $2 != "--input-file" ];
		#then
		#	echo "error: wrong syntax, please show --help"
		#else
		#	if [ $3 == "" ]; 
		#	then
		#		echo "please fill input file path"
		#	fi
		#fi
		#if [ $4 != "--output-dir" ];
		#then
		#	echo "error: wrong syntax, please show --help"
		#else
		#	if [ $5 == "" ];
		#	then
		#		echo "please fill output directory path"
		#	fi
		#fi

	  # lay so dong trong file text va thuc hien lap
		#numline=$(cat $3 | wc -l)
		#i=1
		#while [ $i -le $numline ] ;
		#do
			# lay username
			#username=$(cat $3/pattern | awk -v line=4 'NR==line' | awk '{print $2}' | sed 's/"//g')
			# lay id_student
			#id_student=$(cat $3/pattern |awk -v line=4 'NR==line' | awk '{print $4}'  | sed 's/"//g') 
			# xoa file		
			#rm -f $5/*
			# i++
			#(( i++ ))
		#done
		#echo "erase done"
		#;;

	# The others
	*)
		echo "error: wrong syntax, please show --help"
		;;
esac

