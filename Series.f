        program avg
        real numbers(10000)
        integer m,i
        double precision min,max,av,sum
        read (*,*,ERR=999) m
        if (m .lt. 0) then
        goto 999
        endif
        if(m .eq. 0) then
        min=0
        max=0
        av=0
        sum=0
        goto 998
        endif
        i=1

        do while(i <= m)

        read (*,*,ERR=999) numbers(i)

        i=i+1
        end do
        i=1
        sum=0
        min=numbers(1)
        max=numbers(1)

        do while(i<=m)
        sum=sum + numbers(i)
        if(numbers(i) .lt. min) then
            min=numbers(i)
        end if
        if(numbers(i) .gt. max) then
            max=numbers(i)
        end if
        i=i+1
        end do

        i=1
        av=sum/m
998     write(*,'(A,I5)')'Num:',m
        write(*,'(A,F100.2)')'Sum:', sum
        write(*,'(A,F100.2)')'Avg:', av
        write(*,'(A,F100.2)')'Min',min
        write(*,'(A,F100.2)')'Max',max
        stop
999     write(*,'(A,I5)')'ERR'
        end program avg
