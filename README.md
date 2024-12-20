<h1>L2 Syntax Analyses</h1>

<b>Date completed:</b> May 10, 2023 - May 16, 2023

<h2>Description</h2>
This project used R to analyse first language (L1) transfer in second language (L2) English syntax of native Jordanian Arabic speakers, in terms of data wrangling, visualisation, and statistical modelling.
<br>
<br>
This was completed as part of my final project for the Linguistic as Data Science module. 

<h2>Project Details</h2>
This project was based on the data set that included participants' responses to an acceptability judgement task using a 7-point rating scale from 1 (highly unacceptable) to 7 (highly acceptable). The task required them to judge 24 critical grammatical sentences of the four types: declaratives, definites, indefinites, wh-relatives. 48 “filler” sentences with different structures (12 grammatical, 36 ungrammatical) were also added to distract participants’ attention away from the critical items. 
<br>
<br>
The project aimed to address the research question of whether L1 Jordanian Arabic speakers of L2 English tend to reject indefinite relative clauses with the relative pronoun that as grammatical by first describing the process of how the given data set was tidied and analysed using the Chi-squared statistical test. The participants’ responses were compared between each sentence types, especially between definites and indefinites, presenting the results in a table and figures. It was ultimately concluded that L1 Jordanian Arabic speakers of L2 English tend to reject indefinite clauses with the relative pronoun that, and that advanced L2 English speakers tend to accept it more than intermediate speakers.
<br>
<br>
<h3>Column Information:</h3>

  - <i>ID</i>: the unique identifier for each participant. All participants were Jordanian Arabic speakers of L2 English.
  - <i>Age</i>: the participant’s age at the time of the experiment.
  - <i>Prof</i>: the participant’s score out of 60 on an English proficiency task.
  - <i>Level</i>: the participant’s English level: intermediate or advanced.
  - <i>Place</i>: the participant’s country of birth.
  - <i>A / B / C / D</i> at the start of the label indicates the experimental sentence type.
  - <i>GF / UF</i> at the start of the column label indicates that the item is a grammatical (G) or ungrammatical (U) filler.
  - <i>A number at the end of the column label</i>: This is the item number within that particular type. For example, <code>C05</code> means “the 5th item of type C (indefinite)”.
  - <i>The letter Z at the beginning of each column</i>: Indicates that the cells in that column are z-scores.

<h2>Remarks</h2>

- Sentence types should be re-labelled to have more clear categories. 
- Z-scores or the continuous data could have been used to do more complex statistical analysis of the data. 
