#library(wordcloud)

shinyUI(
  fluidPage(titlePanel("Image Recognition using TensorFlow"),
            tags$hr(),
            fluidRow(
              column(width=4,
                     fileInput('file1', '',accept = c('.jpg','.jpeg')),
                     imageOutput('outputImage')
              ),
              column(width=8,
                     dataTableOutput("tab")
              )
            )
  )
)