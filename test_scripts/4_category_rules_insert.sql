INSERT INTO public.category(category_name)
VALUES
	('Global'),
	('Canada'),
	('United States')
;

-- Ignore Case
INSERT INTO public.category_rule(category_rank, category_id, category_regex) 
VALUES 
	(100, 2, 'canada'),
	
	(111, 2, 'ontario'),
	(112, 2, 'quebec'),
	(113, 2, 'nova scotia'),
	(114, 2, 'new brunswick'),
	(115, 2, 'manitoba'),
	(116, 2, 'british columbia'),
	(117, 2, 'prince edward island'),
	(118, 2, 'saskatchewan'),
	(119, 2, '(newfoundland and labrador)|(newfoundland)'),
	(120, 2, 'northwest territories'),
	(121, 2, 'yukon'),
	(122, 2, 'nunavut'),
	
	(300, 3, '(United States)|(USA)|(UnitedStates)'),
	
	(310, 3, 'alabama'),
	(311, 3, 'alaska'),
	(312, 3, 'american samoa'),
	(313, 3, 'arizona'),
	(314, 3, 'arkansas'),
	(315, 3, 'california'),
	(316, 3, 'colorado'),
	(317, 3, 'connecticut'),
	(318, 3, 'delaware'),
	(319, 3, 'district of columbia'),
	(320, 3, 'florida'),
	(321, 3, 'georgia'),
	(322, 3, 'guam'),
	(323, 3, 'hawaii'),
	(324, 3, 'idaho'),
	(325, 3, 'illinois'),
	(326, 3, 'indiana'),
	(327, 3, 'iowa'),
	(328, 3, 'kansas'),
	(329, 3, 'kentucky'),
	(330, 3, 'louisiana'),
	(331, 3, 'maine'),
	(332, 3, 'maryland'),
	(333, 3, 'massachusetts'),
	(334, 3, 'michigan'),
	(335, 3, 'minnesota'),
	(336, 3, 'minor outlying islands'),
	(337, 3, 'mississippi'),
	(338, 3, 'missouri'),
	(339, 3, 'montana'),
	(340, 3, 'nebraska'),
	(341, 3, 'nevada'),
	(342, 3, 'new hampshire'),
	(343, 3, 'new jersey'),
	(344, 3, 'new mexico'),
	(345, 3, 'new york'),
	(346, 3, 'north carolina'),
	(347, 3, 'north dakota'),
	(348, 3, 'northern mariana islands'),
	(349, 3, 'ohio'),
	(350, 3, 'oklahoma'),
	(351, 3, 'oregon'),
	(352, 3, 'pennsylvania'),
	(353, 3, 'puerto rico'),
	(354, 3, 'rhode island'),
	(355, 3, 'south carolina'),
	(356, 3, 'south dakota'),
	(357, 3, 'tennessee'),
	(358, 3, 'texas'),
	(359, 3, 'u.s. virgin islands'),
	(360, 3, 'utah'),
	(361, 3, 'vermont'),
	(362, 3, 'virginia'),
	(363, 3, 'washington'),
	(364, 3, 'west virginia'),
	(365, 3, 'wisconsin'),
	(366, 3, 'wyoming'),
	
	(1000000, 1, '.') -- Set global by default
;