packages <- c("shiny", "shinydashboard", "ggplot2", "dplyr", "DT", "plotly", "corrplot", "readr", "reshape2")

new_packages <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new_packages)) install.packages(new_packages)

lapply(packages, library, character.only = TRUE)

mental_health_data <- read.csv("C:/Users/felix/Desktop/CODING/felix's works/Mental-Health-On-Suicide-Rates-Trend-Analysis-Prediction/datasets/processed/merged_suicide_mental_health_data.csv")

economic_data <- read.csv("C:/Users/felix/Desktop/CODING/felix's works/Mental-Health-On-Suicide-Rates-Trend-Analysis-Prediction/datasets/processed/CPI_inflation.csv")

mental_health_data <- mental_health_data %>%
  rename(
    Year = Year,
    Province = Geography,
    Indicator = Indicators,
    Value = Percentage
  ) %>%
  mutate(Year = as.integer(Year))

economic_data <- economic_data %>%
  rename(
    Year = Year,
    Province = Geo,
    CPI = CPI,
    Inflation = Inflation_rate
  ) %>%
  mutate(Year = as.integer(Year))

merged_data <- left_join(mental_health_data, economic_data, by = c("Year", "Province"))

ui <- dashboardPage(
  dashboardHeader(title = "Mental Health & Suicide Analysis"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Suicide Trends", tabName = "suicide_trends", icon = icon("chart-line")),
      menuItem("Mental Health Trends", tabName = "mh_trends", icon = icon("brain")),
      menuItem("Economic Factors", tabName = "economic_factors", icon = icon("dollar-sign")),
      menuItem("Predictions", tabName = "predictions", icon = icon("cogs"))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "suicide_trends",
              fluidRow(
                box(
                  title = "Suicide Rate Over Time",
                  status = "primary",
                  solidHeader = TRUE,
                  width = 12,
                  plotlyOutput("suicide_trend_plot", height = "400px")
                )
              )
      ),
      tabItem(tabName = "mh_trends",
              fluidRow(
                box(
                  title = "Mental Health Condition Trends",
                  status = "primary",
                  solidHeader = TRUE,
                  width = 12,
                  selectInput("mh_indicator", "Select Mental Health Indicator:", choices = unique(mental_health_data$Indicator)),
                  plotlyOutput("mh_trend_plot", height = "400px")
                )
              )
      ),
      tabItem(tabName = "economic_factors",
              fluidRow(
                box(
                  title = "CPI & Inflation Trends",
                  status = "primary",
                  solidHeader = TRUE,
                  width = 12,
                  plotlyOutput("economic_trends_plot", height = "400px")
                )
              )
      ),
      tabItem(tabName = "predictions",
              fluidRow(
                box(
                  title = "Machine Learning Model Performance",
                  status = "primary",
                  solidHeader = TRUE,
                  width = 12,
                  tableOutput("ml_results")
                )
              )
      )
    )
  )
)

server <- function(input, output) {
  output$suicide_trend_plot <- renderPlotly({
    suicide_data <- merged_data %>%
      filter(Indicator == "Commit Suicide") %>%
      group_by(Year) %>%
      summarise(Average_Suicide = mean(Value, na.rm = TRUE))
    
    ggplotly(
      ggplot(suicide_data, aes(x = Year, y = Average_Suicide)) +
        geom_line(color = "red", size = 1.2) +
        geom_point(color = "darkred", size = 3) +
        labs(title = "Suicide Rate Over Time", x = "Year", y = "Suicide Rate (%)") +
        theme_minimal()
    )
  })
  
  output$mh_trend_plot <- renderPlotly({
    mh_data <- merged_data %>%
      filter(Indicator == input$mh_indicator) %>%
      group_by(Year) %>%
      summarise(Average_Value = mean(Value, na.rm = TRUE))
    
    ggplotly(
      ggplot(mh_data, aes(x = Year, y = Average_Value)) +
        geom_line(color = "blue", size = 1.2) +
        geom_point(color = "darkblue", size = 3) +
        labs(title = paste(input$mh_indicator, "Trend Over Time"), x = "Year", y = "Percentage (%)") +
        theme_minimal()
    )
  })
  
  output$economic_trends_plot <- renderPlotly({
    econ_data <- economic_data %>%
      group_by(Year) %>%
      summarise(Average_CPI = mean(CPI, na.rm = TRUE), Average_Inflation = mean(Inflation, na.rm = TRUE))
    
    ggplotly(
      ggplot(econ_data, aes(x = Year)) +
        geom_line(aes(y = Average_CPI, color = "CPI"), size = 1.2) +
        geom_line(aes(y = Average_Inflation, color = "Inflation"), size = 1.2) +
        labs(title = "CPI & Inflation Trends", x = "Year", y = "Value") +
        theme_minimal()
    )
  })
  
  output$ml_results <- renderTable({
    data.frame(
      Model = c("Logistic Regression", "Random Forest", "SVM"),
      Accuracy = c("80%", "77.78%", "60%")
    )
  })
}

shinyApp(ui = ui, server = server)
