INSERT INTO public.ioc_filter_pattern(ioc_type_ID, ioc_pattern) 
VALUES
	-- Urls
	(1, '(www\.)?youtube\.com'),
	(1, '(http://|https://)?(www\.)?[a-zA-Z\.]*(cisco|twitter|microsoft|linkedin|facebook|instagram|youtube|thehackernews|reddit|blogger\.googleusercontent)\.com[^@\s]*'),
	(1, '(http://|https://)?(www\.)?[a-zA-Z\.]*(thehackernews\.uk|thehacker\.news)[^@\s]*'),
	
	-- Domains
	(2, '(www\.)?(.+\.)?(whatsapp|cisco|twitter|microsoft|s-microsoft|linkedin|facebook|instagram|youtube|thehackernews|reddit|feedburner|blogger\.googleusercontent)\.com'),
	(2, '(www\.)?(.+\.)?(thehackernews)\.(uk|news)'),
	(2, '(www\.)?(.+\.)?(date)\.now'),
	(2, 'schema\.org'),
	
	-- IPv6
	(4, '::(bef|af)?'),
	
	-- Filenames
	(47, '(bundle|rocket-loader)\.min\.js'),
	(47, 'jquery(-(\.?\d+)*)?(\.slim)?\.min\.js'),
	(47, 'privacy-policy\.html'),
	(47, 'search\.js'),
	(47, 'index\.(html|js)');
	
-- Assumes the use of 
INSERT INTO public.ioc_source_filter_pattern(ioc_type_ID, source_ID, ioc_pattern) 
VALUES
	-- Microsoft japan
	(1, 1, '(http://|https://)?(www\.)?[a-zA-Z\.]*(((js\.monitor\.azure)\.com)|(gfx\.ms))[a-zA-Z/?=\\0-9\-\_\.\&\;#\+]*'),
	(1, 1, '(statics-marketingsites-eus-ms-com\.akamaized\.net)[a-zA-Z/?=\\0-9\-\_\.\&\;#\+]*(override\.css)'),
	
	(2, 1, '(www\.)?(.+\.)?(js\.monitor\.azure|embed\.acast|(dc\.)?services\.visualstudio)\.com'),
	(2, 1, '(www\.)?(.+\.)?(gfx\.ms|akamaized\.net)'),
	(2, 1, 'ai\.operation\.name'),
	(2, 1, 'i\.data'),
	(2, 1, 'o\.properties'),
	(2, 1, 'y\.name'),
	(2, 1, 'm\.sv'),
	(2, 1, 'a\.open'),
	
	(47, 1, 'csatFeedbackWidget\.js'),
	(47, 1, 'ai\.2\.min\.js'),
	
	-- Hacker news
	(1, 2, 'https://feeds\.feedburner\.com/TheHackersNews&quot'),
	(1, 2, '(http://|https://)?(www\.)?[a-zA-Z\.]*(t\.me|(inl02\.netline|api\.whatsapp)\.com)[a-zA-Z/?=\\0-9\-\_\.\&\;#\+]*'),
	
	(2, 1, '(www\.)?(.+\.)?(t\.me|(inl02\.netline|api\.whatsapp)\.com)'),
	(2, 2, 'news\.ycombinator\.com'),
	(2, 2, 'e\.(target|media|link)'),
	(2, 2, '(t|telegram)\.me'),
	(2, 2, 'link\.id'),
	(2, 2, 't\.next'),
	(2, 2, 'static-gap\.cf'),
	
	(9, 2, 'admin@thehackernews\.com'),
	
	(47, 2, '(.*)?hacker-news(.*)?\.html'),
	(47, 2, '(exploitability-is-missing-puzzle-piece|leveraging-ai-as-tool-in-threat|upcoming-hacker-news-webinars|about-us|9-customer-service-chatbots-ranked-for|submit-news|7-resources-to-inform-your-next-hunt)\.html'),
	(47, 2, '(unit|intel|reflectiz-unit|thn|THN|prelude-article-unit|unnit|learn|picus|rx)\.(png|jpg)'),
	(47, 2, 'sw\.js'),
	
	-- Cisco Security
	(47, 3, 'clientlib-base\.min\.js'),
	(47, 3, '(ctm|ctm-core|page-start|page-end(-module)?)\.js');
	