function [well_plate] = regions_rows_beta(locations,mask,image_rgb,single_pixel)
%This function connects the data collected from the leaf discs to the wells
%on the plate. However it will always start counting with naming the row
%thats on the very left as #1

    single_stats = regionprops(mask,image_rgb(:,:,1),'MeanIntensity','MinIntensity','MaxIntensity','Circularity', 'Area','Centroid'); %get value of those three for each iteration

    for q = 1:length(single_stats)
        single_stats(q).centersX = single_stats(q).Centroid(1);
        single_stats(q).centersY = single_stats(q).Centroid(2);    
    end
    
    T = struct2table(single_stats); % convert the struct array to a table
    sortedT = sortrows(T, 'centersX'); % sort the table by 'DOB'
    sortedS = table2struct(sortedT);

    %get plate dimensions aka number of recognized wells per column
    Plate_Dim = [];
    row = 0;
    WelldistX = 5.5 / single_pixel;
    for p = 1:length(sortedS)-1       
        if sortedS(p+1).centersX - sortedS(p).centersX < WelldistX
            row = row+1;
        else sortedS(p+1).centersX - sortedS(p).centersX >= WelldistX;
            Plate_Dim = [Plate_Dim, row+1];
            row = 0;
        end 
    end

    %gets an estimation on which height the each row lies. calculates a
    %average center in RowV 

    Plate_Dim = [Plate_Dim, row+1];
    estPos = [];for u = 1:length(locations); estPos = [estPos, locations(u).centersY]; end 
    estPos = sort(estPos);
    
    WelldistY = 3.42 / single_pixel;
    TF = estPos;
    TF(diff(estPos) < WelldistY) = 0; 

    RowV = [];
    for t = 1:length(estPos)
        PR = [];
        if TF(t) ==0
            PR = [PR, estPos(t)];
        else
            PR = [PR, estPos(t)];
            PRm = mean(PR);
            RowV = [RowV ; PRm];

         end
    end
    

      

        
    %sort everything into well plate format
    %the central Y position of each leaf disk is allowed to shift for 50px
    %in either direction and will be connected to its row.

    count = 1;
    for o = 1:length(Plate_Dim)
        
        RowSingle = sortedS(count:count+Plate_Dim(o)-1); 
        T = struct2table(RowSingle); % convert the struct array to a table
        sortedT = sortrows(T, 'centersY'); % sort the table by 'DOB'
        RowSorted = table2struct(sortedT);
            for p = 1:Plate_Dim(o)
                if RowSorted(p).centersY >= (RowV(1)-WelldistY) && RowSorted(p).centersY <= (RowV(1)+WelldistY)
                    RowSorted(p).Alabel = ['A' num2str(o)];
 
                elseif RowSorted(p).centersY >= (RowV(2)-WelldistY) && RowSorted(p).centersY <= (RowV(2)+WelldistY)
                    RowSorted(p).Alabel = ['B' num2str(o)];

                elseif RowSorted(p).centersY >= (RowV(3)-WelldistY) && RowSorted(p).centersY <= (RowV(3)+WelldistY)
                    RowSorted(p).Alabel = ['C' num2str(o)];

                elseif RowSorted(p).centersY >= (RowV(4)-WelldistY) && RowSorted(p).centersY <= (RowV(4)+WelldistY)
                    RowSorted(p).Alabel = ['D' num2str(o)];
                
                elseif RowSorted(p).centersY >= (RowV(5)-WelldistY) && RowSorted(p).centersY <= (RowV(5)+WelldistY)
                    RowSorted(p).Alabel = ['E' num2str(o)];

                elseif RowSorted(p).centersY >= (RowV(6)-WelldistY) && RowSorted(p).centersY <= (RowV(6)+WelldistY)
                    RowSorted(p).Alabel = ['F' num2str(o)];

                elseif RowSorted(p).centersY >= (RowV(7)-WelldistY) && RowSorted(p).centersY <= (RowV(7)+WelldistY)
                    RowSorted(p).Alabel = ['G' num2str(o)];

                elseif RowSorted(p).centersY >= (RowV(8)-WelldistY) && RowSorted(p).centersY <= (RowV(8)+WelldistY)
                    RowSorted(p).Alabel = ['H' num2str(o)];


                end

             
            end
        %put all in one table
        RowSorted = orderfields(RowSorted);
        well_plate(o).Row = RowSorted;
        count = count + Plate_Dim(o);
    end

    end 


