# RAILS DEMONSTRATION APP WITH ESBUILD

This app is linked with my [YouTube Channel](https://www.youtube.com/@FrancoisDevTech/videos)

## Setup

### Prerequisites

- Ruby version: RUBY_VERSION
- Rails version: Rails RAILS_VERSION
- Install [Mailcatcher](https://mailcatcher.me/).
- Basic knowledge about [Tailwind CSS](https://tailwindcss.com/docs) (it's the CSS framework on this app)


### Prepare

```
gh repo clone git@github.com:francoisedumas/basic_app_esbuild.git
cd basic_app_esbuild
bundle
yarn
rails db:setup
```

### Credentials

Update your credentials with the adpater you want (grover or wicked_pdf)

```
EDITOR="code --wait" rails credentials:edit
pdf_adapter: wicked_pdf
```

### Serve

```
dev
```
