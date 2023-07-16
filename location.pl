property('Apartment C'	,apartment  ,north  ,'St Antoine'	                    ,3	,30000	,'parking & Pool').
property('Apartment D'	,apartment  ,north  ,'Trou aux Biches'	            ,4	,85000	,'parking & Pool').
property('House A'	,house      ,north  ,'Pereybere-Grand Baie'	            ,2	,15000	,'parking').
property('House B'      ,house      ,north  ,'Pointe aux Canonniers-Grand Baie'   ,4  ,25000	,'parking & pool').
property('House C'	,house      ,north  ,'Grand-Gaube'                        ,5  ,70000	,'parking & pool').

property('House K'      ,house      ,south  ,'Vieux Grand Port-Mahebourg'	    ,4	,75000	,'Parking & pool').
property('House L'      ,house      ,south  ,'Beau Vallon -Mahebourg'	            ,3	,46900	,'Parking & pool').
property('House M'      ,house      ,south  ,'Cluny'                	            ,2	,19000	,'Parking & pool').
property('Apartment O'	,apartment  ,south  ,'Souilac'               		    ,1	,6000	,'None').
property('Apartment P'	,apartment  ,south  ,'Riambel-Bel Ombre'		    ,2	,19300	,'None').
property('Apartment Q' 	,apartment  ,south  ,'Blue Bay-Mahebourg'		    ,3	,30000	,'Parking').
property('Apartment R'	,apartment  ,south  ,'Gros Bois-Rose Belle'		    ,5	,75000	,'Pool').

property('Apartment E'  ,apartment  ,east   ,'Champ de Masque'                    ,1  ,9000   ,'None').
property('Apartment F'  ,apartment  ,east   ,'Flacq -Belle Mare'                  ,2  ,15000  ,'Parking').
property('Apartment G'	,apartment  ,east   ,'Haute Rive-Roches Noires'	    ,4	,80000	,'Pool').
property('Apartment H'	,apartment  ,east   ,'Poste Lafayette-Roches Noires'      ,3	,35000	,'None').
property('House D'      ,house      ,east   ,'Beau Champ -Trou deau Douce'        ,5  ,95000  ,'Parking & pool').
property('House E'	,house      ,east   ,'Haute Rive-Roches Noires'	    ,3	,55000	,'Parking & pool').
property('House F'	,house      ,east   ,'Poste de Flacq'          	    ,2	,19500	,'Parking & pool').

property('Apartment L'	,apartment  ,west   ,'Bamboo'                             ,1	,11500	,'None').
property('Apartment M'	,apartment  ,west   ,'Pointe aux Sables,Black River'      ,3	,50000	,'Pool').
property('Apartment N'	,apartment  ,west   ,'Flic en flac'	                    ,2	,18000	,'Pool').
property('House G'      ,apartment  ,west   ,'Albion'	                            ,3	,74500	,'Pool').
property('House H'	,house      ,west   ,'Chamarel -Black River'              ,5  ,160000 ,'Parking & Pool').
property('House I'	,house      ,west   ,'La Gaulette'	                    ,3	,58000	,'Pool').
property('House J'	,house      ,west   ,'Tamarin'	                    ,2	,19900	,'Pool').

property('Apartment S'  ,apartment  ,center ,'Saint-Pierre'                       ,1	,13000	,'Parking').
property('Apartment T'  ,apartment  ,center ,'Moka'	                            ,4	,95000	,'Parking & pool').
property('Apartment U'	,apartment  ,center ,'Quatre Bornes'                      ,3  ,40000  ,'Parking & pool').
property('Apartment V'	,apartment  ,center ,'Montagne Ory-Moka'	            ,2	,25000	,'None').
property('House N'	,house      ,center ,'Floreal-Curepipe'	            ,5	,85000	,'Parking').
property('House O'	,house      ,center ,'Ebene'                              ,3  ,38850  ,'Parking').
property('House P'	,house      ,center ,'Rose-Hill'                          ,2  ,17450  ,'Parking').


% Predicate to display a list of options to the user
display_options([], _).
display_options([Option|Rest], Index) :-
    format('~w. ~w', [Index, Option]), nl,
    NewIndex is Index + 1,
    display_options(Rest, NewIndex).

% Predicate to get user input and validate it
get_user_input(Options, Choice) :-
    read(Index),
    (member(Index, Options) -> Choice = Index; write('Invalid input. Try again: '), get_user_input(Options, Choice)).

% Predicate to recommend a property based on the user's choices
recommend_property(Type, Location, PriceRange, Property) :-
    property(Property, Type, Location, _, _, Price, _),
    Price =< PriceRange.

% Predicate to display the recommended properties
display_recommendations([]).
display_recommendations([Property|Rest]) :-
    write('- '), write(Property), nl,
    display_recommendations(Rest).

% Main predicate to start the expert system
start_expert_system :-
    write('            -------------------------------------------------------------------------'), nl,
    write('                     *****Welcome to our smart Rental expert system.*****'), nl,
    write('            --------------------------------------------------------------------------'), nl, nl,

    repeat,
    % Get the user's preferred property type
    write('Choose a property type (apartment, house):'), nl,
    Types = [apartment, house],
    display_options(Types, 1),
    get_user_input(Types, Type),
    nl, nl,

    % Get the user's preferred location
    write('Choose a location (North, South, East, West, Center):'), nl,
    Locations = [north, south, east, west, center],
    display_options(Locations, 1),
    get_user_input(Locations, Location),
    nl, nl,

    % Get the user's preferred price range
    write('Enter your preferred price range (- answer will be between 0 and your choice):'), nl,
    read(PriceRange),
    nl, nl,

    % Find and recommend suitable properties
    findall(Property, recommend_property(Type, Location, PriceRange, Property), Recommendations),
    (Recommendations = [] -> write('Sorry, no property matching your preferences found.');
    (write('Recommended Properties:'), nl, display_recommendations(Recommendations))),
    nl, nl,

    % Ask the user if they want to rerun the program
    write('Do you want another recommendation ? (yes/no): '), 
    read(Response),nl,nl,nl,
    (Response \= 'yes', Response \= 'y').

% Initialization goal
:- initialization start_expert_system.