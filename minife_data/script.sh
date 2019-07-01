#!/bin/bash

#echo jinang shah

#!/bin/bash
# A shell script to print each number five times.
for (( nn = 16; nn <= 48; nn=nn+16 ))      ### Outer for loop ###
do

    for (( in = 80 ; in <= 120 ; in=in+10 )) ### Inner for loop ###
    do
          for (( jn = 80 ; jn <= 120 ; jn=jn+10 ))
	  do
		  for (( kn = 80 ; kn <= 120 ; kn=kn+10 ))
		  do
			  for(( no = 1 ; no <= 4 ; no=no+1))
			  do

				  echo "$nn $in $jn $kn $no"
				  
				  mpiexec -n $nn -f /users/misc/sjinang/hostfile /users/misc/sjinang/minife/miniFE-master/ref/src/miniFE.x -nx $in -ny $jn -nz $kn -nq $no > output
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

                                          echo "$nn $in $jn $kn" > file
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

