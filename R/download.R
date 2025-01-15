#' Download a specific file from the MADOC dataset
#'
#' @param platform Platform name ('reddit', 'voat', 'bluesky', 'koo')
#' @param community Community name (required for reddit and voat)
#' @param as_dataframe If TRUE, loads the data directly into memory as a data.frame without saving to disk.
#'                     If FALSE, saves the file to disk and returns the filename.
#' @param output_dir Directory to save the downloaded file. Only used when as_dataframe=FALSE.
#' @return If as_dataframe=TRUE, returns a data.frame containing the data.
#'         If as_dataframe=FALSE, returns the filename of the saved file (invisibly).
#' @export
download_file <- function(platform, community = NULL, as_dataframe = FALSE, output_dir = ".") {
  if (!platform %in% PLATFORMS) {
    stop(sprintf("Platform must be one of %s", paste(PLATFORMS, collapse = ", ")))
  }
  
  if (platform %in% c("reddit", "voat")) {
    if (is.null(community) || !community %in% COMMUNITIES) {
      stop(sprintf("Community must be one of %s for %s", 
                  paste(COMMUNITIES, collapse = ", "), platform))
    }
    filename <- sprintf("%s_%s_madoc.parquet", platform, community)
    url <- FILE_URLS[[platform]][[community]]
    expected_size <- FILE_SIZES[[platform]][[community]]
    desc <- sprintf("%s/%s", platform, community)
  } else {
    if (!is.null(community)) {
      stop(sprintf("Community should not be specified for %s", platform))
    }
    filename <- sprintf("%s_madoc.parquet", platform)
    url <- FILE_URLS[[platform]]
    expected_size <- FILE_SIZES[[platform]]
    desc <- platform
  }
  
  if (output_dir != ".") {
    dir.create(output_dir, recursive = TRUE, showWarnings = FALSE)
  }
  
  filepath <- file.path(output_dir, filename)
  
  # Download file
  tryCatch({
    download_with_progress(url, filepath, platform, community, expected_size)
    
    if (as_dataframe) {
      df <- arrow::read_parquet(filepath)
      unlink(filepath)
      cat(sprintf("Loaded %d rows from %s\n", nrow(df), desc))
      return(df)
    } else {
      invisible(filename)  # Return filename without printing
    }
  }, error = function(e) {
    if (file.exists(filepath)) {
      unlink(filepath)
    }
    stop(sprintf("Failed to download file: %s", e$message))
  })
}

#' Download and optionally combine Reddit and Voat data for a specific community
#'
#' @param community Community name
#' @param as_dataframe If TRUE, loads both datasets into memory and returns a combined data.frame without saving files.
#'                     If FALSE, saves both files to disk and returns their filenames.
#' @param output_dir Directory to save the downloaded files. Only used when as_dataframe=FALSE.
#' @return If as_dataframe=TRUE, returns a combined data.frame containing both Reddit and Voat data.
#'         If as_dataframe=FALSE, returns a list with reddit_file and voat_file paths.
#' @export
download_community_pair <- function(community, as_dataframe = FALSE, output_dir = ".") {
  if (!community %in% COMMUNITIES) {
    stop(sprintf("Community must be one of %s", paste(COMMUNITIES, collapse = ", ")))
  }
  
  cat(sprintf("\nDownloading Reddit data for %s...\n", community))
  reddit_df <- download_file("reddit", community, as_dataframe = TRUE)
  
  cat(sprintf("\nDownloading Voat data for %s...\n", community))
  voat_df <- download_file("voat", community, as_dataframe = TRUE)
  
  if (as_dataframe) {
    cat("\nCombining datasets...\n")
    combined_df <- dplyr::bind_rows(reddit_df, voat_df)
    cat(sprintf("Combined dataset has %d rows\n", nrow(combined_df)))
    return(combined_df)
  } else {
    reddit_file <- download_file("reddit", community, output_dir = output_dir)
    voat_file <- download_file("voat", community, output_dir = output_dir)
    return(list(reddit_file = reddit_file, voat_file = voat_file))
  }
}

#' Load a previously downloaded MADOC dataset file
#'
#' @param filename The filename returned by download_file() or one of the filenames from download_community_pair()
#' @return A data.frame containing the data from the parquet file
#' @examples
#' \dontrun{
#' # First download a file
#' filename <- download_file("voat", "gaming")
#' # Then load it
#' df <- load_local(filename)
#' }
#' @export
load_local <- function(filename) {
  if (!file.exists(filename)) {
    stop("File not found. Make sure you've downloaded it first using download_file()")
  }
  if (!grepl("\\.parquet$", filename)) {
    stop("File must be a parquet file (ending in .parquet)")
  }
  df <- arrow::read_parquet(filename)
  cat(sprintf("Loaded %d rows from %s\n", nrow(df), filename))
  return(df)
} 