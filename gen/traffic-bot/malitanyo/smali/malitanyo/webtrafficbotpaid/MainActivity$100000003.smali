.class Lmalitanyo/webtrafficbotpaid/MainActivity$100000003;
.super Ljava/lang/Object;
.source "MainActivity.java"

# interfaces
.implements Landroid/widget/CompoundButton$OnCheckedChangeListener;


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lmalitanyo/webtrafficbotpaid/MainActivity;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x20
    name = "100000003"
.end annotation


# instance fields
.field private final this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

.field private final val$sButton2:Landroid/widget/Switch;


# direct methods
.method constructor <init>(Lmalitanyo/webtrafficbotpaid/MainActivity;Landroid/widget/Switch;)V
    .locals 6

    move-object v0, p0

    move-object v1, p1

    move-object v2, p2

    move-object v4, v0

    invoke-direct {v4}, Ljava/lang/Object;-><init>()V

    move-object v4, v0

    move-object v5, v1

    iput-object v5, v4, Lmalitanyo/webtrafficbotpaid/MainActivity$100000003;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    move-object v4, v0

    move-object v5, v2

    iput-object v5, v4, Lmalitanyo/webtrafficbotpaid/MainActivity$100000003;->val$sButton2:Landroid/widget/Switch;

    return-void
.end method

.method static access$0(Lmalitanyo/webtrafficbotpaid/MainActivity$100000003;)Lmalitanyo/webtrafficbotpaid/MainActivity;
    .locals 4

    move-object v0, p0

    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/MainActivity$100000003;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    move-object v0, v3

    return-object v0
.end method


# virtual methods
.method public onCheckedChanged(Landroid/widget/CompoundButton;Z)V
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "(",
            "Landroid/widget/CompoundButton;",
            "Z)V"
        }
    .end annotation

    .annotation runtime Ljava/lang/Override;
    .end annotation

    .prologue
    .line 112
    move-object v0, p0

    move-object v1, p1

    move v2, p2

    move v4, v2

    if-eqz v4, :cond_0

    .line 115
    move-object v4, v0

    iget-object v4, v4, Lmalitanyo/webtrafficbotpaid/MainActivity$100000003;->val$sButton2:Landroid/widget/Switch;

    const v5, -0xff0100

    invoke-virtual {v4, v5}, Landroid/widget/Switch;->setBackgroundColor(I)V

    .line 116
    move-object v4, v0

    iget-object v4, v4, Lmalitanyo/webtrafficbotpaid/MainActivity$100000003;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    invoke-virtual {v4}, Lmalitanyo/webtrafficbotpaid/MainActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v4

    const-string v5, "JavaScript is Enable"

    const/4 v6, 0x1

    invoke-static {v4, v5, v6}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v4

    invoke-virtual {v4}, Landroid/widget/Toast;->show()V

    .line 123
    :goto_0
    return-void

    .line 122
    :cond_0
    move-object v4, v0

    iget-object v4, v4, Lmalitanyo/webtrafficbotpaid/MainActivity$100000003;->val$sButton2:Landroid/widget/Switch;

    const/high16 v5, -0x10000

    invoke-virtual {v4, v5}, Landroid/widget/Switch;->setBackgroundColor(I)V

    .line 123
    move-object v4, v0

    iget-object v4, v4, Lmalitanyo/webtrafficbotpaid/MainActivity$100000003;->this$0:Lmalitanyo/webtrafficbotpaid/MainActivity;

    invoke-virtual {v4}, Lmalitanyo/webtrafficbotpaid/MainActivity;->getApplicationContext()Landroid/content/Context;

    move-result-object v4

    const-string v5, "JavaScript is Dis-able"

    const/4 v6, 0x1

    invoke-static {v4, v5, v6}, Landroid/widget/Toast;->makeText(Landroid/content/Context;Ljava/lang/CharSequence;I)Landroid/widget/Toast;

    move-result-object v4

    invoke-virtual {v4}, Landroid/widget/Toast;->show()V

    goto :goto_0
.end method
