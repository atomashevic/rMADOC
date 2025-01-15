#' List available platforms and communities in the MADOC dataset
#' 
#' @return Prints formatted list of available data and returns invisible list of platforms and communities
#' @export
list_available_data <- function() {
  cat("\n=== MADOC Dataset Available Files ===\n\n")
  
  # Standalone platforms
  cat("Standalone Platforms:\n")
  cat("--------------------------------------------------\n")
  cat(sprintf("%-12s(%s)\n", "bluesky", format_size(FILE_SIZES$bluesky)))
  cat(sprintf("%-12s(%s)\n", "koo", format_size(FILE_SIZES$koo)))
  
  cat("\nPlatforms with Communities:\n")
  cat("--------------------------------------------------\n\n")
  
  # Reddit communities
  cat("REDDIT:\n")
  for (community in COMMUNITIES) {
    size <- format_size(FILE_SIZES$reddit[[community]])
    cat(sprintf("  %-20s(%s)\n", community, size))
  }
  
  # Voat communities
  cat("\nVOAT:\n")
  for (community in COMMUNITIES) {
    size <- format_size(FILE_SIZES$voat[[community]])
    cat(sprintf("  %-20s(%s)\n", community, size))
  }
  
  cat("\nNote: You can download individual files using:\n")
  cat("  download_file(platform, community)\n\n")
  cat("Or download Reddit-Voat pairs using:\n")
  cat("  download_community_pair(community)\n\n")
  
  # Return invisibly for programmatic use
  invisible(list(
    platforms = PLATFORMS,
    communities = COMMUNITIES
  ))
}

#' Download a file with simple progress indicator
#' @param url URL to download from
#' @param filename Destination filename
#' @param platform Platform name
#' @param community Community name (optional)
#' @param expected_size Expected file size in bytes
#' @keywords internal
download_with_progress <- function(url, filename, platform, community = NULL, expected_size) {
  # Create description for messages
  desc <- if (!is.null(community)) {
    sprintf("%s/%s", platform, community)
  } else {
    platform
  }
  
  cat(sprintf("\nDownloading %s (size: %s)...\n", desc, format_size(expected_size)))
  
  # Simple download with curl
  tryCatch({
    curl::curl_download(url, filename, quiet = FALSE)
    cat(sprintf("Saved to: %s\n", normalizePath(filename)))
  }, error = function(e) {
    if (file.exists(filename)) unlink(filename)
    stop(sprintf("Download failed: %s", e$message))
  })
} 