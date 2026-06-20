.class Lmalitanyo/webtrafficbotpaid/multi$100000001;
.super Ljava/util/TimerTask;
.source "multi.java"


# annotations
.annotation system Ldalvik/annotation/EnclosingClass;
    value = Lmalitanyo/webtrafficbotpaid/multi;
.end annotation

.annotation system Ldalvik/annotation/InnerClass;
    accessFlags = 0x20
    name = "100000001"
.end annotation

.annotation system Ldalvik/annotation/MemberClasses;
    value = {
        Lmalitanyo/webtrafficbotpaid/multi$100000001$100000000;
    }
.end annotation


# instance fields
.field private final this$0:Lmalitanyo/webtrafficbotpaid/multi;


# direct methods
.method constructor <init>(Lmalitanyo/webtrafficbotpaid/multi;)V
    .locals 5

    move-object v0, p0

    move-object v1, p1

    move-object v3, v0

    invoke-direct {v3}, Ljava/util/TimerTask;-><init>()V

    move-object v3, v0

    move-object v4, v1

    iput-object v4, v3, Lmalitanyo/webtrafficbotpaid/multi$100000001;->this$0:Lmalitanyo/webtrafficbotpaid/multi;

    return-void
.end method

.method static access$0(Lmalitanyo/webtrafficbotpaid/multi$100000001;)Lmalitanyo/webtrafficbotpaid/multi;
    .locals 4

    move-object v0, p0

    move-object v3, v0

    iget-object v3, v3, Lmalitanyo/webtrafficbotpaid/multi$100000001;->this$0:Lmalitanyo/webtrafficbotpaid/multi;

    move-object v0, v3

    return-object v0
.end method


# virtual methods
.method public run()V
    .locals 7
    .annotation system Ldalvik/annotation/Signature;
        value = {
            "()V"
        }
    .end annotation

    .annotation runtime Ljava/lang/Override;
    .end annotation

    .prologue
    .line 64
    move-object v0, p0

    move-object v2, v0

    iget-object v2, v2, Lmalitanyo/webtrafficbotpaid/multi$100000001;->this$0:Lmalitanyo/webtrafficbotpaid/multi;

    new-instance v3, Lmalitanyo/webtrafficbotpaid/multi$100000001$100000000;

    move-object v6, v3

    move-object v3, v6

    move-object v4, v6

    move-object v5, v0

    invoke-direct {v4, v5}, Lmalitanyo/webtrafficbotpaid/multi$100000001$100000000;-><init>(Lmalitanyo/webtrafficbotpaid/multi$100000001;)V

    invoke-virtual {v2, v3}, Lmalitanyo/webtrafficbotpaid/multi;->runOnUiThread(Ljava/lang/Runnable;)V

    return-void
.end method
