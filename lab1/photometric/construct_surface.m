function [ height_map ] = construct_surface( p, q, path_type )
%CONSTRUCT_SURFACE construct the surface function represented as height_map
%   p : measures value of df / dx
%   q : measures value of df / dy
%   path_type: type of path to construct height_map, either 'column',
%   'row', or 'average'
%   height_map: the reconstructed surface


if nargin == 2
    path_type = 'column';
end

[h, w] = size(p);
height_map = zeros(h, w);

switch path_type
    case 'column'
        % =================================================================
        % YOUR CODE GOES HERE
        % top left corner of height_map is zero
        % for each pixel in the left column of height_map
        %   height_value = previous_height_value + corresponding_q_value 
        
        % for each row
        %   for each element of the row except for leftmost
        %       height_value = previous_height_value + corresponding_p_value
        
        for i = 1:h
            for j = 1:w
                % -p instead of p to have the same coord system as the 
                % "row" path_type
                height_map(i, j) = sum(-p(i, 1:j)) +  sum(q(1:i, 1));
            end
        end
       
        % =================================================================
               
    case 'row'
        
        % =================================================================
        % YOUR CODE GOES HERE
        for i = 1:h
            for j = 1:w
                height_map(i, j) = sum(p(1, 1:j)) +  sum(q(1:i, j));
            end
        end
       
        % =================================================================
          
    case 'average'
        
        % =================================================================
        % YOUR CODE GOES HERE
        for i = 1:h
            for j = 1:w
                col = sum(-p(i, 1:j)) +  sum(q(1:i, 1));
                row = sum(p(1, 1:j)) +  sum(q(1:i, j));
                height_map(i, j) = (row + col)/2;
            end
        end
       
        
        % =================================================================
end


end

