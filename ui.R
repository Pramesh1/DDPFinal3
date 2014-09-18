library(shiny)
library(xtable)
clist<- c("Afghanistan","Albania","Algeria","Andorra","Angola","Antigua and Barbuda","Argentina","Armenia","Australia","Austria","Azerbaijan","Bahamas",
          "Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bhutan","Bolivia (Plurinational State of)","Bosnia and Herzegovina",
          "Botswana","Brazil","Brunei Darussalam","Bulgaria","Burkina Faso","Burundi","Cambodia","Cameroon","Canada","Cape Verde",
          "Central African Republic","Chad","Chile","China","Colombia","Comoros","Congo","Congo (Democratic Republic of the)","Costa Rica","Croatia",
          "Cote d'Ivoire","Cuba","Cyprus","Czech Republic","Denmark","Djibouti","Dominica","Dominican Republic","Ecuador","Egypt","El Salvador",
          "Equatorial Guinea","Eritrea","Estonia","Ethiopia","Fiji","Finland","France","Gabon","Gambia","Georgia","Germany","Ghana","Greece",
          "Grenada","Guatemala","Guinea","Guinea-Bissau","Guyana","Haiti","Honduras","Hong Kong, China (SAR)","Hungary","Iceland","India",
          "Indonesia","Iran (Islamic Republic of)","Iraq","Ireland","Israel","Italy","Jamaica","Japan","Jordan","Kazakhstan","Kenya","Kiribati",
          "Korea (Republic of)","Kuwait","Kyrgyzstan","Lao People's Democratic Republic","Latvia","Lebanon","Lesotho","Liberia","Libya",
          "Liechtenstein","Lithuania","Luxembourg","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Mauritania","Mauritius","Mexico",
          "Micronesia (Federated States of)","Moldova (Republic of)","Mongolia","Montenegro","Morocco","Mozambique","Myanmar","Namibia","Nepal",
          "Netherlands","New Zealand","Nicaragua","Niger","Nigeria","Norway","Oman","Pakistan","Palau","Palestine, State of","Panama",
          "Papua New Guinea","Paraguay","Peru","Philippines","Poland","Portugal","Qatar","Romania","Russian Federation","Rwanda","Saint Kitts and Nevis",
          "Saint Lucia","Saint Vincent and the Grenadines","Samoa","Sao Tome and Principe","Saudi Arabia","Senegal","Serbia","Seychelles",
          "Sierra Leone","Singapore","Slovakia","Slovenia","Solomon Islands","South Africa","Spain","Sri Lanka","Sudan","Suriname","Swaziland","Sweden",
          "Switzerland","Syrian Arab Republic","Tajikistan","Tanzania (United Republic of)","Thailand","The former Yugoslav Republic of Macedonia",
          "Timor-Leste","Togo","Tonga","Trinidad and Tobago","Tunisia","Turkey","Turkmenistan","Uganda","Ukraine","United Arab Emirates",
          "United Kingdom","United States","Uruguay","Uzbekistan","Vanuatu","Venezuela (Bolivarian Republic of)","Viet Nam","Yemen","Zambia","Zimbabwe")

shinyUI(pageWithSidebar( 
        
        headerPanel("Model: Changes in Qual. of Life if emigrating.. "),          
        sidebarPanel(h4("Information"), 
                     p("The UNDP compiles , on a yearly basis, a global index known as the Human Development Index, 
                        (the higher the better) whereby each country is rated and given a ranking.
                        This simulation uses several of the indicators from the vaailable dataset 
                       to predict how your quality of life could change if you emigrated to somewhere else. The data ,
                       used for this application was downloaded from http://hdr.undp.org/en/data.,
                       The data was then sampled and cleaned, with limited number of variables retained for this simulation."),              
                     h4("Instructions"),
                     p("To use this application, fill in your (1) gender (male/female), (2)current locatrion , (3) where
                your intend to relocation"), 
                     h4("Go!"),
                     selectizeInput("countryNow", label="Where are you you currently living ?",selected = "Mauritius",choices=clist),
                     selectizeInput("countryFuture", label="Where do you plan to Relocate ?",selected = "Germany",choices=clist),
                     selectizeInput("gender", label="Input your gender",selected = "Male",choices=c("Male","Female")),
                     submitButton("Submit")                      
        ), 
        
        mainPanel(                    
                
                p("To avoid information overload, this simulation is limited to 12 indicators but can be modified to include others."),
 #               tableOutput("hdi"),
                verbatimTextOutput("ocountryn"),
                verbatimTextOutput("ocountryf"),
                verbatimTextOutput("ogender"),
                p('Changes to expect if relocating'),
                p('The Country ranking is not in the barplot as it distorts the diagram (changing ranking from 1 to 2 = 100%).',
                'Values in the table and barplot are in',strong('%')),
                p(strong('ERROR HANDLING -- '),'Some countries (only a few) have missing data  - which is also a valuable information -  and I did not want to delete them. In case of error please change your country selection '),
                h5("HDI Country Ranking Change (Real Value, not %)" ),  
                textOutput("rank"),
                h5("Table of Result (%)" ),   
                tableOutput("ohdi2"),
                 h5('Barplot'),
                plotOutput("myPlot"), 
 includeHTML("Legend1.html")
  #              img(src="legend.jpg", align = "left")
 
 
                
                
        )
) 
)