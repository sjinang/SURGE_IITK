#!/bin/bash

#echo jinang shah

#!/bin/bash
# A shell script to print each number five times.
for (( inn = 3; inn <= 6; inn=inn+1 ))      ### Outer for loop ###
do

for (( jnn = 3; (jnn <= 6) && (inn*jnn <= 60); jnn=jnn+1 ))      ### Outer for loop ###
do

for (( knn = 3; (knn <= 6) && (inn*jnn*knn <= 60); knn=knn+1 ))      ### Outer for loop ###
do

    let "nn = $inn * $jnn * $knn"

    for (( in = 30 ; in <= 110 ; in=in+20 )) ### Inner for loop ###
    do
          for (( jn = 40 ; jn <= 120 ; jn=jn+20 ))
	  do
		  for (( kn = 50 ; kn <= 110 ; kn=kn+20 ))
		  do
			  for(( no = 1 ; no <= 4 ; no=no+1))
			  do

				  echo "$inn $jnn $knn $nn $in $jn $kn $no"
		
				  mpiexec -n $nn -f /users/misc/sjinang/hostfile /users/misc/sjinang/comd/CoMD-master/bin/CoMD-mpi -i $inn -j $jnn -k $knn -nx $in -ny $jn -nz $kn -nq $no > output
				  if [ $no -eq 4 ]
				  then

			
					  grep "PAPI_TOT_CYC" output | awk '{print $NF}' > l1_tcm
					  awk -f /users/misc/sjinang/max1.awk l1_tcm > avg1
   					  paste avg1 >> output4
				  fi

				  if [ $no -eq 3 ]
                                  then

                                         
					  grep "PAPI_DP_OPS" output | awk '{print $NF}' > l1_tcm
                                          awk '{ total += $1 ; count++ } END { print total/count }' l1_tcm > avg1
                                          paste avg1 >> output3
                                  fi

				  if [ $no -eq 2 ]
                                  then

                                         
					  grep "PAPI_L2_LDM" output | awk '{print $NF}' > l1_tcm
                                          awk '{ total += $1 ; count++ } END { print total/count }' l1_tcm > avg1
					  grep "PAPI_BR_PRC" output | awk '{print $NF}' > l2_tcm
                                          awk '{ total += $1 ; count++ } END { print total/count }' l2_tcm > avg2
					  grep "PAPI_RES_STL" output | awk '{print $NF}' > l3_tcm
                                          awk '{ total += $1 ; count++ } END { print total/count }' l3_tcm > avg3


                                          paste avg1 avg2 avg3 >> output2
                                  fi

				  if [ $no -eq 1 ]
                                  then

                                          echo "$inn $jnn $knn $in $jn $kn" > file
					  grep "PAPI_L1_TCM" output | awk '{print $NF}' > l1_tcm
                                          awk '{ total += $1 ; count++ } END { print total/count }' l1_tcm > avg1
                                          grep "PAPI_L2_TCM" output | awk '{print $NF}' > l2_tcm
                                          awk '{ total += $1 ; count++ } END { print total/count }' l2_tcm > avg2
                                          grep "PAPI_L1_LDM" output | awk '{print $NF}' > l3_tcm
                                          awk '{ total += $1 ; count++ } END { print total/count }' l3_tcm > avg3

                                          paste file avg1 avg2 avg3 >> output1
					  rm file
                                  fi




				  rm output
				  rm l1_tcm
				  rm avg1

				  if [[ $no -eq 1 ]] || [[ $no -eq 2 ]]
				  then
					  rm l2_tcm
					  rm avg2
					  rm l3_tcm
					  rm avg3
				  fi


			  done


		  done
	  done
	 
   done

done
done
done

