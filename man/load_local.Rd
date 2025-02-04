% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/download.R
\name{load_local}
\alias{load_local}
\title{Load a previously downloaded MADOC dataset file}
\usage{
load_local(filename)
}
\arguments{
\item{filename}{The filename returned by download_file() or one of the filenames from download_community_pair()}
}
\value{
A data.frame containing the data from the parquet file
}
\description{
Load a previously downloaded MADOC dataset file
}
\examples{
\dontrun{
# First download a file
filename <- download_file("voat", "gaming")
# Then load it
df <- load_local(filename)
}
}
