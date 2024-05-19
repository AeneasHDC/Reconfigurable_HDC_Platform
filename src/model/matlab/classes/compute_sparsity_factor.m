%% 
% @author Marco Angioli and Saeid Jamili
% @email marco.angioli@uniroma1.it and saeid.jamili@uniroma1.it
% @note Authors name are listed in alphabetical order
% @date Created on: 12th August 2023
% @date Last updated on: 16th August 2023
% @institution Sapienza University of Rome
% @version 1.0.2
% @section LICENSE
%  Copyright 2024 Sapienza University of Rome
%  Licensed under the Apache License, Version 2.0 (the "License");
%  you may not use this file except in compliance with the License.
%  You may obtain a copy of the License at
%  
%      http://www.apache.org/licenses/LICENSE-2.0
%  
%  Unless required by applicable law or agreed to in writing, software
%  distributed under the License is distributed on an "AS IS" BASIS,
%  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%  See the License for the specific language governing permissions and
%  limitations under the License.
% Authors: Marco Angioli & Saeid Jamili
%%
function sparsity_factor = compute_sparsity_factor(vector)
    total_elements = numel(vector);
    num_ones = sum(vector == 1);
    sparsity_factor = num_ones / total_elements;
end