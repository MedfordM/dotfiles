return {
  {
    'mhartington/formatter.nvim',
    event = 'BufWritePre',
    opts = {
      filetype = {
        java = {
          function ()
            return {
              exe = "google-java-format",
              stdin = true,
              args = {
                "-"
              },
            }
          end
        },
      }
    }
  }
}
