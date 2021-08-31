#' implement T-TEST for 2-level group variable and ANOVA test with POST-HOC for 3 levels and above
#' Default method for POST-HOC p-value adjustment method is TUKEY_HSD
#' 'cp' stands for [c]om[p]arison. 'aov' stands for [a]n[ov]a.
#'
#' @param data wide-format dataset
#' @param ys [vector] y variables
#' @param group.vars group variables
#'
#' @return a list of anova test output and significance test output
#' @export
#'
#' @examples

get_all_compare_means_output <- function(data, ys, group.vars) {
  # output variables --------------------------------------------------------
  cp_output <- data.frame()
  aov_output <- data.frame()

  var_combinations <- expand_grid(group.vars, ys)
  for (i in 1:nrow(var_combinations)) {
    # unpacking for iteration
    var_combination <- var_combinations[i, ]
    group.var <- var_combination$group.vars
    y <- var_combination$ys

    formula <- formula(glue("{y} ~ {group.var}"))

    nlevel <- data %>%
      drop_na(all_of(c(group.var, y))) %>%
      pull(group.var) %>%
      n_distinct()

    # POST-HOC will use TUKEY_HUSD method
    .cp_output <- compare_means(data, formula, add_x_position = FALSE)
    .cp_output <- .cp_output %>%
      rename(
        mean_diff = estimate,
        mean_group1 = estimate1,
        mean_group2 = estimate2,
        y = .y.
      ) %>%
      mutate(
        y = y,
        group.var = group.var
      )
    cp_output %<>% bind_rows(.cp_output)

    # if the group variables has 3 levels or above, implement ANOVA test
    if (nlevel >= 3) {
      anova_obj <- rstatix::Anova(lm(formula = formula, data = data), type = 3)
      .aov_output <-
        rstatix::anova_summary(anova_obj, detailed = TRUE, effect.size = "pes")[2, ] %>%
        rstatix::add_significance(p.col = "p", output.col = "p<.05") %>%
        mutate(y = y)
      aov_output %<>% bind_rows(.aov_output)
    }
  }

  cp_output %<>% mutate(
    mean_sd_group1 = paste0(format(round(mean_group1, 2), nsmall = 2), "±", format(round(sd_group1, 2), nsmall = 2)),
    mean_sd_group2 = paste0(format(round(mean_group2, 2), nsmall = 2), "±", format(round(sd_group2, 2), nsmall = 2))
  )
  cp_output %<>% rename(t = statistic)
  .cols_cp <- c(
    "y",
    "group.var",
    "group1",
    "group2",
    "n1",
    "n2",
    "mean_group1",
    "mean_group2",
    "mean_diff",
    "sd_group1",
    "sd_group2",
    "mean_sd_group1",
    "mean_sd_group2",
    "t",
    "p",
    "p.signif",
    "p.adj",
    "p.adj.signif",
    "description.signif",
    "df",
    "conf.low",
    "conf.high",
    "method",
    "alternative"
  )
  cp_output <- cp_output %>% dplyr::select(any_of(.cols_cp))

  if (!is_empty(aov_output)) {
    aov_output %<>% rename(
      partial_eta_squared = pes,
      group.var = Effect,
      sum_of_squares_effect = SSn,
      sum_of_squares_error = SSd,
      df_between = DFn,
      df_within = DFd,
      p.signif = `p<.05`
    )
    .cols_aov <-
      c(
        "y",
        "group.var",
        "df_between",
        "df_within",
        "sum_of_squares_effect",
        "sum_of_squares_error",
        "F",
        "p",
        "p.signif",
        "partial_eta_squared"
      )

    aov_output <- aov_output[.cols_aov]
  }
  return(list(anova = aov_output, comparison = cp_output))
}
