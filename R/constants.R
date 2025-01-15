#' URLs and constants for MADOC dataset
#' @keywords internal

FILE_URLS <- list(
  bluesky = "https://zenodo.org/records/14637314/files/bluesky_madoc.parquet",
  koo = "https://zenodo.org/records/14637314/files/koo_madoc.parquet",
  reddit = list(
    CringeAnarchy = "https://zenodo.org/records/14637314/files/reddit_CringeAnarchy_madoc.parquet",
    fatpeoplehate = "https://zenodo.org/records/14637314/files/reddit_fatpeoplehate_madoc.parquet",
    funny = "https://zenodo.org/records/14637314/files/reddit_funny_madoc.parquet",
    gaming = "https://zenodo.org/records/14637314/files/reddit_gaming_madoc.parquet",
    gifs = "https://zenodo.org/records/14637314/files/reddit_gifs_madoc.parquet",
    greatawakening = "https://zenodo.org/records/14637314/files/reddit_greatawakening_madoc.parquet",
    KotakuInAction = "https://zenodo.org/records/14637314/files/reddit_KotakuInAction_madoc.parquet",
    MensRights = "https://zenodo.org/records/14637314/files/reddit_MensRights_madoc.parquet",
    milliondollarextreme = "https://zenodo.org/records/14637314/files/reddit_milliondollarextreme_madoc.parquet",
    pics = "https://zenodo.org/records/14637314/files/reddit_pics_madoc.parquet",
    technology = "https://zenodo.org/records/14637314/files/reddit_technology_madoc.parquet",
    videos = "https://zenodo.org/records/14637314/files/reddit_videos_madoc.parquet"
  ),
  voat = list(
    CringeAnarchy = "https://zenodo.org/records/14637314/files/voat_CringeAnarchy_madoc.parquet",
    fatpeoplehate = "https://zenodo.org/records/14637314/files/voat_fatpeoplehate_madoc.parquet",
    funny = "https://zenodo.org/records/14637314/files/voat_funny_madoc.parquet",
    gaming = "https://zenodo.org/records/14637314/files/voat_gaming_madoc.parquet",
    gifs = "https://zenodo.org/records/14637314/files/voat_gifs_madoc.parquet",
    greatawakening = "https://zenodo.org/records/14637314/files/voat_greatawakening_madoc.parquet",
    KotakuInAction = "https://zenodo.org/records/14637314/files/voat_KotakuInAction_madoc.parquet",
    MensRights = "https://zenodo.org/records/14637314/files/voat_MensRights_madoc.parquet",
    milliondollarextreme = "https://zenodo.org/records/14637314/files/voat_milliondollarextreme_madoc.parquet",
    pics = "https://zenodo.org/records/14637314/files/voat_pics_madoc.parquet",
    technology = "https://zenodo.org/records/14637314/files/voat_technology_madoc.parquet",
    videos = "https://zenodo.org/records/14637314/files/voat_videos_madoc.parquet"
  )
)

# File sizes in bytes
FILE_SIZES <- list(
  bluesky = 449.3 * 1024 * 1024,  # 449.3 MB
  koo = 774.3 * 1024 * 1024,      # 774.3 MB
  reddit = list(
    CringeAnarchy = 951.7 * 1024 * 1024,        # 951.7 MB
    fatpeoplehate = 214.5 * 1024 * 1024,        # 214.5 MB
    funny = 9.1 * 1024 * 1024 * 1024,           # 9.1 GB
    gaming = 7.2 * 1024 * 1024 * 1024,          # 7.2 GB
    gifs = 3.1 * 1024 * 1024 * 1024,            # 3.1 GB
    greatawakening = 179.3 * 1024 * 1024,       # 179.3 MB
    KotakuInAction = 1.5 * 1024 * 1024 * 1024,  # 1.5 GB
    MensRights = 797.8 * 1024 * 1024,           # 797.8 MB
    milliondollarextreme = 170.2 * 1024 * 1024, # 170.2 MB
    pics = 8.3 * 1024 * 1024 * 1024,            # 8.3 GB
    technology = 2.5 * 1024 * 1024 * 1024,      # 2.5 GB
    videos = 6.5 * 1024 * 1024 * 1024           # 6.5 GB
  ),
  voat = list(
    CringeAnarchy = 476.2 * 1024,               # 476.2 KB
    fatpeoplehate = 61.9 * 1024 * 1024,         # 61.9 MB
    funny = 18.8 * 1024 * 1024,                 # 18.8 MB
    gaming = 12.7 * 1024 * 1024,                # 12.7 MB
    gifs = 2.8 * 1024 * 1024,                   # 2.8 MB
    greatawakening = 76.1 * 1024 * 1024,        # 76.1 MB
    KotakuInAction = 1.8 * 1024 * 1024,         # 1.8 MB
    MensRights = 792.6 * 1024,                  # 792.6 KB
    milliondollarextreme = 3.5 * 1024 * 1024,   # 3.5 MB
    pics = 5.3 * 1024 * 1024,                   # 5.3 MB
    technology = 15.2 * 1024 * 1024,            # 15.2 MB
    videos = 102.4 * 1024                       # 102.4 KB
  )
)

PLATFORMS <- names(FILE_URLS)
COMMUNITIES <- names(FILE_URLS$reddit)  # Same communities for reddit and voat

#' Format file size in human readable format
#' @param size Size in bytes
#' @return Character string with formatted size
#' @keywords internal
format_size <- function(size) {
  units <- c('B', 'KB', 'MB', 'GB', 'TB')
  i <- floor(log(size, 1024))
  size <- size / (1024 ^ i)
  sprintf("%.1f %s", size, units[i + 1])
}

#' Get human readable time estimate
#' @param bytes_per_sec Download speed in bytes per second
#' @param total_bytes Total file size in bytes
#' @return Character string with time estimate
#' @keywords internal
format_time <- function(bytes_per_sec, total_bytes) {
  # Handle edge cases
  if (length(bytes_per_sec) == 0 || bytes_per_sec <= 0 || 
      is.na(bytes_per_sec) || !is.finite(bytes_per_sec)) {
    return("calculating...")
  }
  
  seconds <- total_bytes / bytes_per_sec
  if (is.na(seconds) || !is.finite(seconds)) {
    return("calculating...")
  }
  
  if (seconds < 60) {
    return(sprintf("%.0f seconds", seconds))
  } else if (seconds < 3600) {
    return(sprintf("%.1f minutes", seconds/60))
  } else {
    return(sprintf("%.1f hours", seconds/3600))
  }
}

#' Print download progress with size and speed information
#' @param platform Platform name
#' @param community Community name (optional)
#' @param downloaded_bytes Bytes downloaded so far
#' @param total_bytes Total file size
#' @param bytes_per_sec Download speed in bytes/sec
#' @keywords internal
print_progress <- function(platform, community = NULL, downloaded_bytes, total_bytes, bytes_per_sec) {
  # Construct file description
  if (!is.null(community)) {
    desc <- sprintf("%s/%s", platform, community)
  } else {
    desc <- platform
  }
  
  # Format sizes
  downloaded <- format_size(downloaded_bytes)
  total <- format_size(total_bytes)
  speed <- format_size(bytes_per_sec)
  
  # Calculate percentage
  pct <- round(100 * downloaded_bytes / total_bytes)
  
  # Calculate time remaining
  remaining_bytes <- total_bytes - downloaded_bytes
  time_left <- format_time(bytes_per_sec, remaining_bytes)
  
  # Create progress bar
  width <- 30
  filled <- round(width * downloaded_bytes / total_bytes)
  bar <- paste0(
    "[",
    paste(rep("=", filled), collapse = ""),
    ">",
    paste(rep(" ", width - filled), collapse = ""),
    "]"
  )
  
  # Print status line (clearing previous line)
  cat(sprintf("\r\033[K%s %s %s/%s [%d%%] %s/s ETA: %s",
              desc, bar, downloaded, total, pct, speed, time_left))
  
  # If download complete, add newline
  if (downloaded_bytes >= total_bytes) {
    cat("\n")
  }
}

#' Print success message after download
#' @param filepath Full path to downloaded file
#' @param size File size in bytes
#' @keywords internal
print_success <- function(filepath, size) {
  cat(sprintf("\nSuccessfully downloaded file (size: %s)\n", format_size(size)))
  cat(sprintf("Saved to: %s\n", normalizePath(filepath)))
} 