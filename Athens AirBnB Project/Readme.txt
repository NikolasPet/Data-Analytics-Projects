Project Description: Exploratory Visual Analysis of Airbnb Listings in Athens, Greece

In this data analytics project, I am performing an exploratory visual analysis of Airbnb listings data for the city of Athens, Greece. The primary goal is to gain insights into various aspects of the listings, such as their prices, ratings, and geographical distribution.

Data and Preprocessing:

I am using the "listings.csv.gz" and "calendar.csv.gz" files obtained from the Inside Airbnb website.
The initial preprocessing involves removing empty rows and columns from the dataset, as well as converting the "price" column from a string to a float format, making it suitable for price analysis.

Visualizations:

Bar Chart - Average Price by Neighbourhood: I created a bar chart displaying the top 15 neighbourhoods with the highest average listing prices. This visualization helps to identify areas with more expensive accommodations.

Pie Chart - Number of Listings by Neighbourhood: A pie chart is used to show the distribution of listings among the various neighbourhoods. The top 10 neighbourhoods are individually labeled, while the rest are grouped under "Rest."

Histograms - Rating Scores and Number of Reviews: Two histograms are plotted: one for the distribution of rating scores and the other for the number of reviews. These charts provide insights into the concentration of rating scores and the popularity of listings based on the number of reviews they received.

Scatter Plot - Price vs. Review Scores Rating: A scatter plot is used to examine the relationship between listing prices and their corresponding review scores ratings. This visualization shows the distribution of listings with respect to their ratings and prices.

Box Plots - Price Distribution by Neighbourhood: I created box plots to examine the price distribution for the 4 most expensive neighbourhoods. The plots show the median, Q1, and Q3 values, helping to identify potential differences in pricing patterns among these areas.

Area Plot - Average Prices Over Time: An area chart is used to visualize the average listing prices over time. This chart highlights any significant changes in prices and allows the reader to identify potential anomalies or trends.

Map - Geographical Distribution of Listings: I used Folium to create a map of Athens, Greece, and mark the geographical locations of the Airbnb listings on the map. The listings are grouped into clusters, with each cluster representing the number of listings in a specific area.

Conclusion:
The exploratory visual analysis provides valuable insights into the Airbnb listings in Athens, Greece. It reveals trends in pricing, popularity, and geographical distribution of listings. I am identifying areas with higher average prices and a concentration of highly-rated listings. Additionally, I am pointing out any anomalies or interesting patterns that may require further investigation. Overall, this project serves as a fundamental exploration of the dataset and can be used as a starting point for more in-depth analysis or data-driven decision-making in the hospitality industry.
