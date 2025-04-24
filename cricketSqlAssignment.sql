SELECT
   c.PlayerName,p.PlayerName AS CaptainName  
FROM
  players p  
RIGHT JOIN
  players c ON p.PlayerID=c.CaptainID;
