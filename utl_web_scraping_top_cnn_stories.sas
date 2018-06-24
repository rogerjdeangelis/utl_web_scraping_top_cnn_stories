Web scraping top CNN stories

github
https://github.com/rogerjdeangelis/utl_web_scraping_top_cnn_stories

see
https://tinyurl.com/y8o2n36h
https://stackoverflow.com/questions/50998136/how-to-extract-news-web-scrapings-into-csv-file-and-how-to-append-new-records


INPUT (CNN Page)
=================

 http://money.cnn.com
                               ___ _ __  _ __    _ __ ___   ___  _ __   ___ _   _
                              / __| '_ \| '_ \  | '_ ` _ \ / _ \| '_ \ / _ \ | | |
                             | (__| | | | | | | | | | | | | (_) | | | |  __/ |_| |
                              \___|_| |_|_| |_| |_| |_| |_|\___/|_| |_|\___|\__, |
   *** We Want These Top Stories ***                                         |___/
   =================================
+----------------------------------------+                                    +---------------------+
| TOP STRORIES                           |                                    | MOST ACTIVE STOCKS  |
|  The weird reason that mighty Amazon   |    GLEN BECKS WALKS OFF CNN        |                     |
|                                        |                                    |   S&P 500S&P 1500   |
|  Xiaomi wants to raise over $6 billion |    INTERVIEW OVER QUESTIONS        |   ---------------   |
|                                        |                                    |                     |
|  Jurassic World sequel crosses $700    |    ON THE MEDIA                    |   FCX  +0.08/0.49%  |
|                                        |                                    |                     |
|  Why GE may need to stop paying its    |                                    |   AKS +0.21/4.50%   |
|                                        |                                    |                     |
|  Toyota updates the Century, car of    |                                    |   CLF +0.40/4.65%   |
| ...                                    |                                    | ...                 |
|                                        |                                    |                     |
+----------------------------------------+                                    +---------------------+


 EXAMPLE OUTPUT

 WORK.WANTWPS total obs=39

 INDEX    TOPSTORIES

    0     The weird reason that mighty Amazon isn't in the Dow
    1     Xiaomi wants to raise over $6 billion in Hong Kong IPO
    2     Jurassic World sequel crosses $700 million at global box office
    3     Why GE may need to stop paying its 119-year old dividend
    4     Toyota updates the Century, car of choice for Japan's elites
    5     One innovative solution to the health care worker shortage
    6     What higher wages means for Domino's and McDonald's
    7     Apple promises free repairs for faulty MacBook keyboards
    8     'Jurassic World' sequel has big opening day amid a surging box office
    9     What's behind Tom Arnold's bizarre anti-Trump media blitz


PROCESS  (working code - two lines of code?)
=======================================

Key Text
<span class="aa8468e9 e01d3fdb">The weird reason that mighty Amazon isn&#x27;t in the Dow<!-- -->
</span>

d = soup(requests.get('http://money.cnn.com/').text, 'html.parser');
articles = list(filter(None, [i.text for i in d.find_all('span', {'class':re.compile('^\w+ _\w+|^\w+$')})]))[2:];


OUTPUT
======

WORK.WANTWPS total obs=39

 INDEX    TOPSTORIES

    0     The weird reason that mighty Amazon isn't in the Dow
    1     Xiaomi wants to raise over $6 billion in Hong Kong IPO
    2     Jurassic World sequel crosses $700 million at global box office
    3     Why GE may need to stop paying its 119-year old dividend
    4     Toyota updates the Century, car of choice for Japan's elites
    5     One innovative solution to the health care worker shortage
    6     What higher wages means for Domino's and McDonald's
    7     Apple promises free repairs for faulty MacBook keyboards
    8     'Jurassic World' sequel has big opening day amid a surging box office
    9     What's behind Tom Arnold's bizarre anti-Trump media blitz
   ...
   33     Drought woes? This tech can literally make it rain
   34     Airbus: Brexit chaos threatens our future in UK
   35     Report: Prosecutors subpoena National Enquirer records in Michael Cohen investigation
   36     Rachel Maddow breaks down in tears while discussing border crisis
   37     Nearly a quarter of Americans have no emergency savings
   38     Top bitcoin exchange says over $30 million in cryptocurrencies stolen


*                _               _       _
 _ __ ___   __ _| | _____     __| | __ _| |_ __ _
| '_ ` _ \ / _` | |/ / _ \   / _` |/ _` | __/ _` |
| | | | | | (_| |   <  __/  | (_| | (_| | || (_| |
|_| |_| |_|\__,_|_|\_\___|   \__,_|\__,_|\__\__,_|

;

  http://money.cnn.com

 *          _       _   _
 ___  ___ | |_   _| |_(_) ___  _ __
/ __|/ _ \| | | | | __| |/ _ \| '_ \
\__ \ (_) | | |_| | |_| | (_) | | | |
|___/\___/|_|\__,_|\__|_|\___/|_| |_|

;

%utl_submit_wps64("
options set=PYTHONHOME 'C:\Progra~1\Python~1.5\';
options set=PYTHONPATH 'C:\Progra~1\Python~1.5\\lib\';
libname wrk sas7bdat '%sysfunc(pathname(work))';
proc python;
submit;
from bs4 import BeautifulSoup as soup;
import requests, re;
import pandas as pd;
import csv;
d = soup(requests.get('http://money.cnn.com/').text, 'html.parser');
articles = list(filter(None, [i.text for i in d.find_all('span', {'class':re.compile('^\w+ _\w+|^\w+$')})]))[2:];
want=pd.DataFrame(articles);
want.columns = ['TopStories'];
want.reset_index(inplace=True);
endsubmit;
import python=want data=wrk.wantwps;
run;quit;
");

LOG

1         options set=PYTHONHOME 'C:\Progra~1\Python~1.5\';
2         options set=PYTHONPATH 'C:\Progra~1\Python~1.5\\lib\';
3         libname wrk sas7bdat 'e:\saswork\wrk\_TD6532_BEAST_';
NOTE: Library wrk assigned as follows:
      Engine:        SAS7BDAT
      Physical Name: e:\saswork\wrk\_TD6532_BEAST_

4         proc python;
5         submit;
6         from bs4 import BeautifulSoup as soup
7         import requests, re
8         import pandas as pd
9         import csv
10        d = soup(requests.get('http://money.cnn.com/').text, 'html.parser')
11        articles = list(filter(None, [i.text for i in d.find_all('span', {'class
12        want=pd.DataFrame(articles)
13        want.columns = ['TopStories']
14        want.reset_index(inplace=True)
15        endsubmit;

NOTE: Submitting statements to Python:


16        import python=want data=wrk.wantwps;
NOTE: Creating data set 'WRK.wantwps' from Python data frame 'want'
NOTE: Data set "WRK.wantwps" has 39 observation(s) and 2 variable(s)

17        run;
NOTE: Procedure python step took :
      real time : 1.301
      cpu time  : 0.015


